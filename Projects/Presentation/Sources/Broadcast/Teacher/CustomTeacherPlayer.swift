//
//  CustomTeacherPlayer.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import HaishinKit
import Domain

public struct CustomTeacherPlayer: UIViewRepresentable {
    private let provider: StreamProvider

    public init(provider: StreamProvider) {
        self.provider = provider
    }

    public func makeUIView(context: Context) -> MTHKView {
        let view = MTHKView(frame: .zero)
        view.videoGravity = .resizeAspectFill
        // 💡 주입받은 provider에게 "네가 알아서 붙여라"라고 위임
        provider.attach(to: view)
        return view
    }

    public func updateUIView(_ uiView: MTHKView, context: Context) {}
}
