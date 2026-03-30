//
//  StudentViewModel.swift
//  Presentation
//
//  Created by 김동율 on 3/31/26.
//

// StudentViewModel.swift
import AVFoundation
import Combine

final class StudentViewModel: ObservableObject {
    @Published var player: AVPlayer?

    private let streamURL: URL

    init(streamURL: URL) {
        self.streamURL = streamURL
    }

    func onAppear() {
        setupAudioSession()
        let player = AVPlayer(url: streamURL)
        self.player = player
        player.play()
    }

    func onDisappear() {
        player?.pause()
        player = nil
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("오디오 세션 세팅 실패: \(error.localizedDescription)")
        }
    }
}
