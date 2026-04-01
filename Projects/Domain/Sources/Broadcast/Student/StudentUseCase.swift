//
//  StudentUseCase.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//

import Foundation
import AVFoundation

public protocol StudentUseCase {
    func configureAudioSession()
    func executePlay(url: URL)
    func executeStop()
    func getPlayer() -> AVPlayer?
}
