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
            // ... 생략 ...

            WebRTCView(viewModel: webRTCViewModel)
                .tabItem {
                    Label("WebRTC", systemImage: "video.square.fill")
                }
            
            // ... 생략 ...
        }
    }
}
#Preview {
    RootView()
}
