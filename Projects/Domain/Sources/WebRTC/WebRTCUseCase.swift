//
//  WebRTCUseCase.swift
//  Domain
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC

/// ViewModel에서 호출하는 WebRTC 관련 기능 명세서
public protocol WebRTCUseCase {
    func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent>
    func executeLeave()
    // 자바스크립트에서 그렇게 질리도록 들었던 getusermedia... 어우 지겹다 신입때 들엇던거
    func getLocalVideoTrack() -> RTCVideoTrack?
    func controlAudio(isOn: Bool)
    func controlVideo(isOn: Bool)
}
