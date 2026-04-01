//
//  StudentViewModel.swift
//  Presentation
//
//  Created by 김동율 on 3/31/26.
//



import Foundation
import AVFoundation
import Domain

@MainActor
final class StudentViewModel: ObservableObject {
    @Published private(set) var player: AVPlayer?
    @Published private(set) var isConnected: Bool = false

    private let useCase: StudentUseCase
    private let streamURL: URL

    init(useCase: StudentUseCase, streamURL: URL) {
        self.useCase = useCase
        self.streamURL = streamURL
    }

    func onAppear() {
        useCase.configureAudioSession()
        useCase.executePlay(url: streamURL)
        player = useCase.getPlayer()
        isConnected = true
    }

    func onDisappear() {
        useCase.executeStop()
        player = nil
        isConnected = false
    }
}
