//
//  WebRTCViewModel.swift
//  Presentation
//
//  Created by enm on 2/11/26.
//

// 1:1 과외 화면의 상태를 관리!!
// usecase와 연결.
// @mainactor로 모든 메인스레드에서 진행


import Foundation
import WebRTC
import Domain

@MainActor
public final class WebRTCViewModel: ObservableObject {
    
    @Published public var remoteStreams: [String: RTCVideoTrack] = [:]
    @Published public var isMicOn: Bool = true
    @Published public var isCameraOn: Bool = true
    
    private let useCase: WebRTCUseCase
    
    // 뷰에 전달할 식별자 (WebRTC 의존성 분리)
    public var remoteParticipantIDs: [String] {
        Array(remoteStreams.keys)
    }
    public let myId: String = "teacher"
    
    public init(useCase: WebRTCUseCase) {
        self.useCase = useCase
    }
    
    public func joinRoom(role: UserRole) {
        Task {
            for await event in await useCase.executeJoin(role: role) {
                switch event {
                case .videoTrackAdded(let id, let track):
                    self.remoteStreams[id] = track
                default:
                    break
                }
            }
        }
    }
    
    public func getLocalVideoTrack() -> RTCVideoTrack? {
        useCase.getLocalVideoTrack()
    }
    
    public func leaveRoom() {
        useCase.executeLeave()
    }
    
    public func toggleMic() {
        isMicOn.toggle()
        useCase.controlAudio(isOn: isMicOn)
    }

    public func toggleCamera() {
        isCameraOn.toggle()
        useCase.controlVideo(isOn: isCameraOn)
    }
}
