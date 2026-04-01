//
//  TeacherPlayerView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import HaishinKit

struct TeacherPlayerView: UIViewRepresentable {
    let stream: RTMPStream

    func makeUIView(context: Context) -> MTHKView {
        let view = MTHKView(frame: .zero)
        view.videoGravity = .resizeAspectFill
        view.attachStream(stream)
        return view
    }

    func updateUIView(_ uiView: MTHKView, context: Context) {}
}
