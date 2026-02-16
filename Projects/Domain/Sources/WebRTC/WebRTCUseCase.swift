//
//  WebRTCUseCase.swift
//  Domain
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC

// usecase 함수들. 프로토콜로 정의.
public protocol WebRTCUseCase {
    // 방에들어오면 비동기로 스트림 처리.
    // 질문예상: 학새잉 들어오면 방만들수잇나???
    // 답변: 지금은 사이드 프로젝트라서 하드코딩으로 해놓았다. 추후에 서버에서 오는 토큰으로 버튼 선생일때만 보이게 할 것이다. 일단 Enum으로 UserRole로 나눠났었고, 나중에 할수있다.
    func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent>
    
    func executeLeave()
    
    func getLocalVideoTrack() -> RTCVideoTrack?
    
    func configureAudio(isOn: Bool)
    func configureVideo(isOn: Bool)
}
