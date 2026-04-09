//
//  DIContainer.swift
//  App
//
//  Created by enm on 4/9/26.
//

import Foundation
import Domain
import Data
import Presentation

public final class DIContainer {
    public static let shared = DIContainer()
    
    private init() {}
    
    /// WebRTC 관련 의존성 조립소
    @MainActor
    public func makeWebRTCViewModel() -> WebRTCViewModel {
        // 1. 실제 구현체 생성 (Data 계층)
        let manager = WebRTCManager()
        
        // 2. 비즈니스 로직 주입 (Domain 계층)
        let useCase = WebRTCUseCaseImpl(webRTCManager: manager)
        
        // 3. 뷰모델 생성 및 반환 (Presentation 계층)
        return WebRTCViewModel(useCase: useCase)
    }
    
    // 이후 Teacher, Student, Chat 뷰모델 생성 로직도
    // 동일한 패턴으로 여기에 추가하시면 됩니다.
}
