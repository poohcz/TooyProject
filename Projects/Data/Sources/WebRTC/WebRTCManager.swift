//
//  WebRTCManager.swift
//  Data
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC
import Domain
import AVFoundation

public final class WebRTCManager: NSObject, WebRTCManagerProtocol {
    public var localVideoTrack: RTCVideoTrack?
    public var localAudioTrack: RTCAudioTrack?
    public var onEvent: ((WebRTCEvent) -> Void)?
    
    // WebRTC 연결의 핵심 팩토리 (메모리 관리 및 객체 생성을 담당)
    private let factory: RTCPeerConnectionFactory = {
        RTCInitializeSSL() // SSL 초기화 (보안 연결 필수)
        return RTCPeerConnectionFactory(
            encoderFactory: RTCDefaultVideoEncoderFactory(),
            decoderFactory: RTCDefaultVideoDecoderFactory()
        )
    }()
    
    // 카메라 영상 캡처를 담당하는 객체
    private var videoCapturer: RTCCameraVideoCapturer?
    // WebRTCManager 클래스 상단에 있어야 할 선언
    private var peerConnection: RTCPeerConnection?
    
    public override init() {
        super.init()
        // 실제 구현 시 여기서 카메라 캡처 세션을 시작하고 localVideoTrack을 생성합니다.
        print("카메라켜기1")
        setupLocalVideo()
        setupLocalAudio()
    }
    
    private func setupLocalVideo() {
        let videoSource = factory.videoSource()
        videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        localVideoTrack = factory.videoTrack(with: videoSource, trackId: "video0")
        
        let devices = RTCCameraVideoCapturer.captureDevices()
        guard let device = devices.first(where: { $0.position == .front }) else { return }

        // 1. 해당 기기가 지원하는 모든 포맷을 가져옵니다.
        let formats = RTCCameraVideoCapturer.supportedFormats(for: device)
        
        // 2. [핵심] 원하는 해상도를 필터링합니다. (예: 1280x720)
        // CMVideoFormatDescriptionGetDimensions를 통해 해상도 값을 확인합니다.
        let targetWidth: Int32 = 1280
        let targetHeight: Int32 = 720
        
        let selectedFormat = formats.first { format in
            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            return dimensions.width == targetWidth && dimensions.height == targetHeight
        } ?? formats.last! // 만약 딱 맞는 해상도가 없으면 가장 좋은 것으로 대체

        // 3. 해당 포맷에서 지원하는 최대 FPS를 가져옵니다.
        let fps = selectedFormat.videoSupportedFrameRateRanges.first?.maxFrameRate ?? 30

        // 4. 결정된 포맷으로 캡처 시작!
        videoCapturer?.startCapture(with: device, format: selectedFormat, fps: Int(fps))
        
        let finalDim = CMVideoFormatDescriptionGetDimensions(selectedFormat.formatDescription)
        print("설정된 해상도: \(finalDim.width)x\(finalDim.height) @\(fps)fps ")
    }
    
    private func setupLocalAudio() {
        // 1. 오디오 소스 생성
        let audioSource = factory.audioSource(with: nil)
        
        // 2. 오디오 트랙 생성 (이 코드가 실행될 때 시스템이 마이크 권한을 확인합니다)
        localAudioTrack = factory.audioTrack(with: audioSource, trackId: "audio0")
        
        print("마이크 트랙 생성 완료")
    }

    public func leave() {
        videoCapturer?.stopCapture() // 나갈 때 카메라 끄기
        videoCapturer = nil
    }

    /// 마이크를 끄거나 켭니다.
    public func setAudio(isOn: Bool) {
        // 1. 피어 커넥션이 있는지 먼저 확인합니다.
        guard let pc = self.peerConnection else {
            print("아직 연결 설정이 되지 않았습니다.")
            return
        }
        
        // 2. 피어 커넥션 안에 있는 모든 송신자(senders)를 조사합니다.
        for sender in pc.senders {
            // 3. 그 송신자가 다루는 트랙이 '오디오 트랙'인지 확인합니다.
            if let audioTrack = sender.track as? RTCAudioTrack {
                audioTrack.isEnabled = isOn
            }
        }
        print("마이크 상태 변경: \(isOn ? "ON" : "OFF")")
    }

    /// 내 카메라를 끄거나 켭니다.
    public func setVideo(isOn: Bool) {
        // 1. 내 로컬 프리뷰 트랙은 연결 여부와 상관없이 끕니다.
        localVideoTrack?.isEnabled = isOn
        
        // 2. 피어 커넥션이 있다면 상대방에게 가는 영상도 끕니다.
        if let pc = self.peerConnection {
            for sender in pc.senders {
                // 3. 비디오 트랙인지 확인 후 조절
                if let videoTrack = sender.track as? RTCVideoTrack {
                    videoTrack.isEnabled = isOn
                }
            }
        }
        print("카메라 상태 변경: \(isOn ? "ON" : "OFF")")
    }
}

// WebRTC 라이브러리에서 발생하는 콜백을 처리하는 확장(Extension)
extension WebRTCManager: RTCPeerConnectionDelegate {
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {}
    
    // 가장 중요한 메서드: 상대방 영상 스트림이 추가되었을 때 실행됨
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        if let track = stream.videoTracks.first {
            // Domain 레이어에 정의한 이벤트를 통해 뷰모델까지 영상을 전달
            onEvent?(.videoTrackAdded("remote_peer", track))
        }
    }
    
    // 아래는 WebRTC 프로토콜 유지를 위한 필수 구현 메서드들
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {}
    public func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {}
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCPeerConnectionState) {}
}
