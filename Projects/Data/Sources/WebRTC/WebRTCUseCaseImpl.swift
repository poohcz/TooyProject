//
//  WebRTCUseCaseImpl.swift
//  Domain
//
//  Created by 김동율 on 2/11/26.
//

import Foundation
import Domain


public final class WebRTCUseCaseImpl: WebRTCUseCase {
    private let webRTCManager: WebRTCManagerProtocol
    
    public init(webRTCManager: WebRTCManagerProtocol) {
        self.webRTCManager = webRTCManager
    }
    
    public func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent> {
        return AsyncStream { [weak webRTCManager] continuation in
            webRTCManager?.onEvent = { event in
                continuation.yield(event)
            }
            // onEvent 세팅 후에 join 호출
            webRTCManager?.join()
        }
    }
    
    public func executeLeave() {
        webRTCManager.leave()
    }
    
    public func controlAudio(isOn: Bool) {
        webRTCManager.setAudio(isOn: isOn)
    }

    public func controlVideo(isOn: Bool) {
        webRTCManager.setVideo(isOn: isOn)
    }
}
