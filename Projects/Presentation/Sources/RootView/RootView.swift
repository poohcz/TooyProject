//
//  RootView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            BroadcastView(viewModel: BroadcastViewModel())
                .tabItem {
                    Label("Broadcast", systemImage: "video")
                }
            WebRTCView()
                .tabItem {
                    Label("WebRTC", systemImage: "video.square.fill")
                }
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message")
                }
        }
    }
}

#Preview {
    RootView()
}
