//
//  WebRTCVideoView.swift
//  Presentation
//
//  Created by 김동율 on 2/11/26.
//


import SwiftUI
import WebRTC
import Domain

public struct WebRTCVideoView: UIViewRepresentable {
    public let videoTrack: any VideoTrack  // RTCVideoTrack → any VideoTrack

    public init(videoTrack: any VideoTrack) {
        self.videoTrack = videoTrack
    }

    public func makeUIView(context: Context) -> RTCMTLVideoView {
        let view = RTCMTLVideoView(frame: .zero)
        view.videoContentMode = .scaleAspectFill
        videoTrack.addRenderer(view)  // .add(view) → .addRenderer(view)
        return view
    }

    public func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {}
}

