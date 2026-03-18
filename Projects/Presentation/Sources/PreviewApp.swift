//
//  PreviewApp.swift
//  Presentation
//
//  Created by enm on 2/4/26.
//

import SwiftUI

@main
struct PreviewApp: App {
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(onAnimationFinished: {
                    showSplash = false
                })
            } else {
                RootView()
            }
        }
    }
}
