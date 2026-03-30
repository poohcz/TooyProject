//
//  CustomStudentPlayer.swift
//  Presentation
//
//  Created by 김동율 on 3/5/26.
//

import Foundation
import UIKit
import AVKit
import SwiftUI


struct CustomStudentPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        
        controller.showsPlaybackControls = false
        
        controller.allowsPictureInPicturePlayback = true
        controller.canStartPictureInPictureAutomaticallyFromInline = true
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // 업데이트 로직은 필요 없음
    }
}
