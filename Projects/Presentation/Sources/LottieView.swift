//
//  LottieView.swift
//  Presentation
//
//  Created by enm on 3/11/26.
//

import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    let name: String
    let bundle: Bundle
    let loopMode: LottieLoopMode

    public init(name: String, bundle: Bundle = .main, loopMode: LottieLoopMode = .playOnce) {
        self.name = name
        self.bundle = bundle
        self.loopMode = loopMode
    }

    public func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name, bundle: bundle)
        view.contentMode = .scaleAspectFit
        view.loopMode = loopMode
        view.play()
        return view
    }

    public func updateUIView(_ uiView: LottieAnimationView, context: Context) {}
}
