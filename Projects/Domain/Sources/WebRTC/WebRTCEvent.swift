//
//  WebrtcEvent.swift
//  Domain
//
//  Created by enm on 2/11/26.
//

import Foundation
import WebRTC

// 앱 내에서의 역할 구분
public enum UserRole {
    case broadcaster // 선생님 (송출자)
    case viewer      // 학생 (시청자)
}

// WebRTC 연결 과정에서 발생하는 사건들
public enum WebRTCEvent {
    case peerJoined(String)                 // 새로운 사람이 들어옴
    case peerLeft(String)                   // 사람이 나감
    case videoTrackAdded(String, RTCVideoTrack) // 중요! 상대방 영상 데이터가 도착함 (화면에 그릴 타이밍)
    case connectionStateChanged(Bool)       // 연결 성공/실패 상태 변화
    case error(String)                      // 에러 발생 시 메시지 전달
}

// Data 레이어의 WebRTCManager가 구현해야 할 인터페이스(설계도)
public protocol WebRTCManagerProtocol: AnyObject {
    var localVideoTrack: RTCVideoTrack? { get } // 내 카메라 화면
    var onEvent: ((WebRTCEvent) -> Void)? { get set } // 이벤트를 밖으로 던져주는 클로저
    func leave()              // 연결 종료 및 리소스 정리
    func setAudio(isOn: Bool) // 마이크 제어
    func setVideo(isOn: Bool) // 카메라 제어
}
