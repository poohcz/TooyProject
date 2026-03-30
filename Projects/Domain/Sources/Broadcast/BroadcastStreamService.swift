//
//  BroadcastStreamService.swift
//  Domain
//
//  Created by 김동율 on 3/31/26.
//

import SwiftUI

public protocol BroadcastStreamService {
    func startStream(url: String, key: String)
    func stopStream()
    func makePreviewView() -> AnyView
}
