//
//  RTCVideoTrackWrapper.swift
//  Data
//
//  Created by 김동율 on 3/30/26.
//

import WebRTC
import Domain

public final class RTCVideoTrackWrapper: VideoTrack {
    private let track: RTCVideoTrack

    public init(track: RTCVideoTrack) {
        self.track = track
    }

    public var trackId: String {
        track.trackId
    }

    public func addRenderer(_ renderer: AnyObject) {
        guard let renderer = renderer as? RTCVideoRenderer else { return }
        track.add(renderer)
    }

    public func removeRenderer(_ renderer: AnyObject) {
        guard let renderer = renderer as? RTCVideoRenderer else { return }
        track.remove(renderer)
    }
}
