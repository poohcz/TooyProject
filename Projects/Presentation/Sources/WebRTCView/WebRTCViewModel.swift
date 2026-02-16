//
//  WebRTCViewModel.swift
//  Presentation
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC
import Domain

// 1:1 과외 화면의 상태를 관리!!
// usecase와 연결.
// @mainactor로 모든 메인스레드에서 진행
@MainActor
public final class WebRTCViewModel: ObservableObject {
    
    // MARK: - Combine Properties (UI가 관찰하는 상태)
    // 상대(학생) 영상 관리. 보면 딕셔너리.
    @Published public var remoteStreams: [String: RTCVideoTrack] = [:]
    @Published public var isMicOn: Bool = true
    @Published public var isCameraOn: Bool = true
    
    // MARK: - Properties
    private let useCase: WebRTCUseCase
    
    // MARK: - Initializer
    public init(useCase: WebRTCUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Public Methods (UI에서 호출하는 인터페이스)
    // 방장이만든 방에 들어올때 실행되는거. 비동기로 처리했음.
    public func joinRoom(role: UserRole) {
        Task {
            for await event in await useCase.executeJoin(role: role) {
                switch event {
                case .videoTrackAdded(let id, let track):
                    // Dictionary가 업데이트되면 SwiftUI View가 이를 감지하여 원격 영상을 화면에 뿌림. 중요!
                    self.remoteStreams[id] = track
                default:
                    break
                }
            }
        }
    }
    
    // 내 카메라 가져옴
    public func getLocalVideoTrack() -> RTCVideoTrack? {
        useCase.getLocalVideoTrack()
    }
    
    // 방떠날때 초기화
    public func leaveRoom() {
        useCase.executeLeave()
    }
    
    // 내 마이크 설정
    public func toggleMic() {
        isMicOn.toggle()
        useCase.configureAudio(isOn: isMicOn)
    }

    // 내 카메라 설정
    public func toggleCamera() {
        isCameraOn.toggle()
        useCase.configureVideo(isOn: isCameraOn)
    }
}
