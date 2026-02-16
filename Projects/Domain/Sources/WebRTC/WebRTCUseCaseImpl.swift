//
//  WebRTCUseCaseImpl.swift
//  Domain
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC

public final class WebRTCUseCaseImpl: WebRTCUseCase {
    private let webRTCManager: WebRTCManagerProtocol
    
    public init(webRTCManager: WebRTCManagerProtocol) {
        self.webRTCManager = webRTCManager
    }
    
    // 뷰모델이 방에 입장할 때 호출. AsyncStream을 통해 이벤트를 계속 흘려보냄.
    public func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent> {
        return AsyncStream { continuation in
            // Manager에서 발생하는 이벤트를 받아서 스트림으로 전달
            webRTCManager.onEvent = { event in
                continuation.yield(event)
            }
            // 여기서 실제 P2P 시그널링(연결 시도) 로직이 시작되어야 함
        }
    }
    
    public func executeLeave() {
        webRTCManager.leave()
    }
    
    public func getLocalVideoTrack() -> RTCVideoTrack? {
        return webRTCManager.localVideoTrack
    }
    
    public func configureAudio(isOn: Bool) {
        webRTCManager.setAudio(isOn: isOn)
    }

    public func configureVideo(isOn: Bool) {
        webRTCManager.setVideo(isOn: isOn)
    }
}
