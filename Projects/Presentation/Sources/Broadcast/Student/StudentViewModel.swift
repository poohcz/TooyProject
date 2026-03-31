//
//  StudentViewModel.swift
//  Presentation
//
//  Created by 김동율 on 3/31/26.
//



import Foundation
import Combine

@MainActor
final class StudentViewModel: ObservableObject {
    @Published private(set) var isPlaying: Bool = false
    
    private let useCase: StudentUseCase
    private let streamURL: URL

    init(useCase: StudentUseCase, streamURL: URL) {
        self.useCase = useCase
        self.streamURL = streamURL
    }

    /// 💡 뷰에서 직접 player를 꺼내 쓸 수 있도록 UseCase의 객체를 전달만 함
    var player: Any? {
        useCase.getPlayer()
    }

    func onAppear() {
        useCase.configureAudioSession()
        useCase.executePlay(url: streamURL)
        isPlaying = true
    }

    func onDisappear() {
        useCase.executeStop()
        isPlaying = false
    }
}
