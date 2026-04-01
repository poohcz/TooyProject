//
//  StudentUseCaseImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import AVFoundation
import Domain

public final class StudentUseCaseImpl: StudentUseCase {
    
    private var player: AVPlayer?
    
    public init() {}
    
    public func configureAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    public func executePlay(url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    public func executeStop() {
        player?.pause()
        player = nil
    }
    
    public func getPlayer() -> AVPlayer? {
        return player
    }
}
