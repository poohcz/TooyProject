//
//  WebRTCUseCase.swift
//  Domain
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC

/// 뷰모델이 유스케이스에게 시킬 수 있는 일들의 목록입니다.
public protocol WebRTCUseCase {
    /// 방에 참여하고 발생하는 이벤트들을 실시간 스트림으로 반환합니다.
    func executeJoin(role: UserRole) async -> AsyncStream<WebRTCEvent>
    
    /// 방을 나갈 때 호출합니다.
    func executeLeave()
    
    /// 내 로컬 카메라 트랙을 가져옵니다.
    func getLocalVideoTrack() -> RTCVideoTrack?
    
    /// setAudio, setVideo입니다용.
    func configureAudio(isOn: Bool)
    func configureVideo(isOn: Bool)
}
