//
//  WebRTCUseCase.swift
//  Domain
//
//  Created by 김동율 on 2/11/26.
//

import Foundation

// ViewModel에서 호출하는 WebRTC 관련 기능 명세서
public protocol WebRTCUseCase {
    func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent>
    func executeLeave()
    func controlAudio(isOn: Bool)
    func controlVideo(isOn: Bool)
}
