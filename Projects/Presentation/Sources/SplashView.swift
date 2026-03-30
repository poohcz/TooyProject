//
//  SplashView.swift
//  Presentation
//
//  Created by 김동율 on 3/11/26.
//

import SwiftUI
import Lottie


public struct SplashView: View {
    @State private var isFinished = false
    @State private var scale: CGFloat = 0.9
    
    var onAnimationFinished: () -> Void

    public init(onAnimationFinished: @escaping () -> Void) {
        self.onAnimationFinished = onAnimationFinished
    }
    

    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            LottieView(name: "appSplash", bundle: .module)
                .frame(height: 300)
                .clipped()
                .padding(.horizontal, 30)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                scale = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                onAnimationFinished()
            }
        }
    }
}
