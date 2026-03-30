//
//  WebrtcEvent.swift
//  Domain
//
//  Created by 김동율 on 2/11/26.
//

import Foundation

public enum UserRole {
    case broadcaster
    case viewer
}

public protocol VideoTrack: AnyObject {
    var trackId: String { get }
    func addRenderer(_ renderer: AnyObject)
    func removeRenderer(_ renderer: AnyObject)
}

public enum WebRTCEvent {
    case peerJoined(String)
    case peerLeft(String)
    case localVideoTrackReady(any VideoTrack)
    case videoTrackAdded(String, any VideoTrack)
    case videoTrackRemoved(String)
    case connectionStateChanged(Bool)
    case error(String)
}

public protocol WebRTCManagerProtocol: AnyObject {
    var onEvent: ((WebRTCEvent) -> Void)? { get set }
    func join()
    func leave()
    func setAudio(isOn: Bool)
    func setVideo(isOn: Bool)
}
