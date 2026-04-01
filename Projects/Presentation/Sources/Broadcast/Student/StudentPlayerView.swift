//
//  StudentPlayerView.swift
//  Presentation
//
//  Created by 김동율 on 4/1/26.
//

import SwiftUI
import AVKit

struct StudentPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        controller.allowsPictureInPicturePlayback = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
