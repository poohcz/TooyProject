//
//  TeacherPlayerView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import HaishinKit
import Domain

public struct TeacherPlayerView: UIViewRepresentable {
    private let stream: StreamProvider

    public init(stream: StreamProvider) {
        self.stream = stream
    }

    public func makeUIView(context: Context) -> MTHKView {
        let view = MTHKView(frame: .zero)
        view.videoGravity = .resizeAspectFill
        stream.attach(to: view)
        return view
    }

    public func updateUIView(_ uiView: MTHKView, context: Context) {}
}
