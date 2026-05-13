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
    public let videoTrack: any VideoTrack

    public init(videoTrack: any VideoTrack) {
        self.videoTrack = videoTrack
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(videoTrack: videoTrack)
    }

    public func makeUIView(context: Context) -> RTCMTLVideoView {
        let view = RTCMTLVideoView(frame: .zero)
        view.videoContentMode = .scaleAspectFill
        videoTrack.addRenderer(view)
        context.coordinator.rendererView = view
        return view
    }

    public func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {}

    public static func dismantleUIView(_ uiView: RTCMTLVideoView, coordinator: Coordinator) {
        coordinator.videoTrack.removeRenderer(uiView)
    }

    public class Coordinator {
        let videoTrack: any VideoTrack
        weak var rendererView: RTCMTLVideoView?

        init(videoTrack: any VideoTrack) {
            self.videoTrack = videoTrack
        }
    }
}
