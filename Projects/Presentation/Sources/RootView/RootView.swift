//
//  RootView.swift
//  Presentation
//

import SwiftUI
import Domain
import Data

public struct RootView: View {
    @StateObject private var webRTCViewModel: WebRTCViewModel
    @StateObject private var broadcastViewModel = BroadcastViewModel()
    
    public init() {
        let manager = WebRTCManager()
        let useCase = WebRTCUseCaseImpl(webRTCManager: manager)
        _webRTCViewModel = StateObject(wrappedValue: WebRTCViewModel(useCase: useCase))
    }
    
    public var body: some View {
        TabView {
            WebRTCView(viewModel: webRTCViewModel)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
                .tabItem { Label("수업", systemImage: "video.fill") }.tag(0)
                
            BroadcastView(viewModel: broadcastViewModel)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
                .tabItem { Label("라이브", systemImage: "antenna.radiowaves.left.and.right") }.tag(1)
                
            ChatView()
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
                .tabItem { Label("채팅", systemImage: "message.fill") }.tag(2)
                
            StudentView()
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color(uiColor: .systemBackground), for: .tabBar)
                .tabItem { Label("수강생", systemImage: "play.tv.fill") }.tag(3)
        }
    }
}
