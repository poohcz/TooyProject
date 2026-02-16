//
//  WebRTCVideoView.swift
//  Presentation
//
//  Created by enm on 2/11/26.
//

import SwiftUI
import WebRTC

public struct WebRTCVideoView: UIViewRepresentable {
    public let videoTrack: RTCVideoTrack
    
    public init(videoTrack: RTCVideoTrack) {
        self.videoTrack = videoTrack
    }
    
    public func makeUIView(context: Context) -> RTCMTLVideoView {
        let view = RTCMTLVideoView(frame: .zero)
        view.videoContentMode = .scaleAspectFill
        videoTrack.add(view)
        return view
    }
    
    public func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {}
}

