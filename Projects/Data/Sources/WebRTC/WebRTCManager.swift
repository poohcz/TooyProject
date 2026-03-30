//
//  WebRTCManager.swift
//  Data
//
//  Created by 김동율 on 2/11/26.
//

import Foundation
import WebRTC
import Domain
import AVFoundation
import SocketIO


public final class WebRTCManager: NSObject, WebRTCManagerProtocol {
    public var localVideoTrack: RTCVideoTrack?
    public var localAudioTrack: RTCAudioTrack?
    public var onEvent: ((WebRTCEvent) -> Void)?
    private let maxStudents = 2
    
    // WebRTC 연결 팩토리
    private let factory: RTCPeerConnectionFactory = {
        RTCInitializeSSL()
        return RTCPeerConnectionFactory(
            encoderFactory: RTCDefaultVideoEncoderFactory(),
            decoderFactory: RTCDefaultVideoDecoderFactory()
        )
    }()
    
    private var videoCapturer: RTCCameraVideoCapturer?
    
    // 딕셔너리로 무조건해야함. 1:N 할려면. 이전회사에서도 그렇게함... 근데 이중배열도 되던데.. 그때 왜 이중배열로했지-_-;;
    private var peerConnections: [String: RTCPeerConnection] = [:]
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    private let myUserId = UUID().uuidString
    
    public override init() {
        super.init()
        print("카메라켜기1")
        setupLocalVideo()
        setupLocalAudio()
        setupSocket()
    }
    
    private func setupLocalVideo() {
        let videoSource = factory.videoSource()
        videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        localVideoTrack = factory.videoTrack(with: videoSource, trackId: "video0")
        
        let devices = RTCCameraVideoCapturer.captureDevices()
        guard let device = devices.first(where: { $0.position == .front }) else { return }
        let formats = RTCCameraVideoCapturer.supportedFormats(for: device)
        
        let targetWidth: Int32 = 1280
        let targetHeight: Int32 = 720
        
        let selectedFormat = formats.first { format in
            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            return dimensions.width == targetWidth && dimensions.height == targetHeight
        } ?? formats.last!
        
        let fps = selectedFormat.videoSupportedFrameRateRanges.first?.maxFrameRate ?? 30
        videoCapturer?.startCapture(with: device, format: selectedFormat, fps: Int(fps))
        
        if let track = localVideoTrack {
            onEvent?(.localVideoTrackReady(RTCVideoTrackWrapper(track: track)))
        }
    }
    
    private func setupLocalAudio() {
        let audioSource = factory.audioSource(with: nil)
        localAudioTrack = factory.audioTrack(with: audioSource, trackId: "audio0")
    }

    public func leave() {
        videoCapturer?.stopCapture()
        videoCapturer = nil
        socket.disconnect()
    }

    public func setAudio(isOn: Bool) {
        // 모든 피어 커넥션을 순회하며 마이크 상태 변경 (1:N 대응)
        for (_, pc) in peerConnections {
            for sender in pc.senders {
                if let audioTrack = sender.track as? RTCAudioTrack {
                    audioTrack.isEnabled = isOn
                }
            }
        }
        print("마이크 상태 변경: \(isOn ? "ON" : "OFF")")
    }
    
    public func join() {
        if let track = localVideoTrack {
            onEvent?(.localVideoTrackReady(RTCVideoTrackWrapper(track: track)))
        }
        socket.connect()
    }
    
    public func setVideo(isOn: Bool) {
        // 1. 내 로컬 프리뷰 트랙 제어
        localVideoTrack?.isEnabled = isOn
        
        // 2. 모든 피어 커넥션을 순회하며 송출 영상 제어 (1:N 대응)
        for (_, pc) in peerConnections {
            for sender in pc.senders {
                if let videoTrack = sender.track as? RTCVideoTrack {
                    videoTrack.isEnabled = isOn
                }
            }
        }
        print("카메라 상태 변경: \(isOn ? "ON" : "OFF")")
    }

    private func setupSocket() {
        // local ip임 지금은 임시
        guard let url = URL(string: "http://192.168.219.100:3000") else { return }
        
        socketManager = SocketManager(socketURL: url, config: [.log(false), .compress])
        socket = socketManager.defaultSocket
        
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("WebRTCManager Socket connected!")
            self?.socket.emit("join_room", "room1")
        }
        
        socket.on("user_joined") { [weak self] data, ack in
            guard let newUserId = data[0] as? String else { return }
            print("새 유저 입장: \(newUserId), Offer 전송 시작")
            self?.createOffer(for: newUserId)
        }
        
        socket.on("offer") { [weak self] data, ack in
            guard let dict = data[0] as? [String: Any],
                  let senderId = dict["senderId"] as? String,
                  let sdp = dict["sdp"] as? String else { return }
            self?.handleOffer(sdp: sdp, from: senderId)
        }
        
        socket.on("answer") { [weak self] data, ack in
            guard let dict = data[0] as? [String: Any],
                  let senderId = dict["senderId"] as? String,
                  let sdp = dict["sdp"] as? String else { return }
            self?.handleAnswer(sdp: sdp, from: senderId)
        }
        
        socket.on("ice_candidate") { [weak self] data, ack in
            guard let dict = data[0] as? [String: Any],
                  let senderId = dict["senderId"] as? String,
                  let candidateDict = dict["candidate"] as? [String: Any],
                  let sdpMid = candidateDict["sdpMid"] as? String,
                  let sdpMLineIndex = candidateDict["sdpMLineIndex"] as? Int32,
                  let sdp = candidateDict["sdp"] as? String else { return }
            
            let candidate = RTCIceCandidate(sdp: sdp, sdpMLineIndex: sdpMLineIndex, sdpMid: sdpMid)
            self?.peerConnections[senderId]?.add(candidate) { error in
                if let error = error {
                    print("ICE Candidate 추가 에러: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    // 특정 유저를 위한 PeerConnection 생성
    // turn돈나감... 일단 stun으로 테스트...무료로 1년이든 6개월이든 araboja
    private func createPeerConnection(for userId: String) -> RTCPeerConnection? {
        // 이미 연결된 유저면 기존 거 반환
        if let existing = peerConnections[userId] { return existing }
        
        // 최대 인원 초과 시 거부
        // view에 어떻게 넘길지 고민할 것.
        guard peerConnections.count < maxStudents else {
            print("최대 인원 초과: \(userId) 연결 거부")
            onEvent?(.error("수업 인원이 가득 찼습니다."))
            return nil
        }
        
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        
        guard let pc = factory.peerConnection(with: config, constraints: constraints, delegate: self) else { return nil }
        
        if let localVideoTrack = localVideoTrack { pc.add(localVideoTrack, streamIds: ["stream0"]) }
        if let localAudioTrack = localAudioTrack { pc.add(localAudioTrack, streamIds: ["stream0"]) }
        
        peerConnections[userId] = pc
        return pc
    }
    
    // 전화 걸기 (Offer)
    private func createOffer(for targetUserId: String) {
        guard let pc = createPeerConnection(for: targetUserId) else { return }
        let constraints = RTCMediaConstraints(mandatoryConstraints: ["OfferToReceiveVideo": "true", "OfferToReceiveAudio": "true"], optionalConstraints: nil)
        
        pc.offer(for: constraints) { [weak self] sdp, error in
            guard let sdp = sdp, let self = self else { return }
            pc.setLocalDescription(sdp, completionHandler: { _ in })
            self.socket.emit("offer", ["targetId": targetUserId, "senderId": self.myUserId, "sdp": sdp.sdp])
        }
    }
    
    // 전화 받기 및 응답 (Answer)
    private func handleOffer(sdp: String, from senderId: String) {
        guard let pc = createPeerConnection(for: senderId) else { return }
        let sessionDescription = RTCSessionDescription(type: .offer, sdp: sdp)
        
        pc.setRemoteDescription(sessionDescription) { [weak self] error in
            guard let self = self else { return }
            let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
            pc.answer(for: constraints) { answerSdp, error in
                guard let answerSdp = answerSdp else { return }
                pc.setLocalDescription(answerSdp, completionHandler: { _ in })
                self.socket.emit("answer", ["targetId": senderId, "senderId": self.myUserId, "sdp": answerSdp.sdp])
            }
        }
    }
    
    // 응답 처리
    private func handleAnswer(sdp: String, from senderId: String) {
        guard let pc = peerConnections[senderId] else { return }
        let sessionDescription = RTCSessionDescription(type: .answer, sdp: sdp)
        pc.setRemoteDescription(sessionDescription, completionHandler: { _ in })
    }
}


extension WebRTCManager: RTCPeerConnectionDelegate {
    public func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {}
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {}
    
    // 영상이 도착하면 뷰모델로 던짐! 아오 복잡해. webrtc를 domain에서 몰라야 하기 때문에 한번더 깜싼다. 즉, import Webrtc를 안한다.(도메인에서)
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        if let track = stream.videoTracks.first {
            // 어떤 사람한테서 온 영상인지 ID를 찾음
            if let userId = peerConnections.first(where: { $0.value == peerConnection })?.key {
                print("[WebRTCManager] 비디오 트랙 수신 완료: \(userId)")
                onEvent?(.videoTrackAdded(userId, RTCVideoTrackWrapper(track: track)))
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {}
    public func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {}
    
    // 네트워크 경로(ICE) 찾으면 서버로 전달
    public func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        if let userId = peerConnections.first(where: { $0.value == peerConnection })?.key {
            let candidateData: [String: Any] = [
                "targetId": userId, "senderId": myUserId,
                "candidate": ["sdp": candidate.sdp, "sdpMLineIndex": candidate.sdpMLineIndex, "sdpMid": candidate.sdpMid ?? ""]
            ]
            socket.emit("ice_candidate", candidateData)
        }
    }
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {}
}
