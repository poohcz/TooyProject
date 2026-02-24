//
//  RootView.swift
//  Presentation
//

import SwiftUI
import Domain
import Data

public struct RootView: View {
    // 앱이 살아있는 동안 객체들을 유지하기 위해 State로 관리합니다.
    @StateObject private var webRTCViewModel: WebRTCViewModel
    
    public init() {
        // 의존성 주입 (Dependency Injection) 로직
        let manager = WebRTCManager()
        let useCase = WebRTCUseCaseImpl(webRTCManager: manager)
        _webRTCViewModel = StateObject(wrappedValue: WebRTCViewModel(useCase: useCase))
    }
    
    public var body: some View {
        TabView {
            // 1. 수업 탭 (기존 브로의 WebRTCView)
            WebRTCView(viewModel: webRTCViewModel)
                .tabItem {
                    Label("수업", systemImage: "video.fill")
                }
                .tag(0)
            
            // 2. 채팅 탭 
            ChatView()
                .tabItem {
                    Label("채팅", systemImage: "message.fill")
                }
                .tag(1)
        }
    }
}
#Preview {
    RootView()
}
