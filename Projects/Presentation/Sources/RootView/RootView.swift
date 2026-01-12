//
//  RootView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import Data  // import 추가
import Domain  // 이것도 필요할 수 있음

public struct RootView: View {
    
    public init() {}
    
    // body는 1개만!
    public var body: some View {
        TabView {
            makeBroadcastView()
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
    
    // DI 함수
    private func makeBroadcastView() -> some View {
        let repository = BroadcastRepositoryImpl()
        let useCase = BroadcastUseCaseImpl(repository: repository)
        let viewModel = BroadcastViewModel(broadcastUseCase: useCase)
        return BroadcastView(viewModel: viewModel)
    }
}

#Preview {
    RootView()
}
