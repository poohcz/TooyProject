//
//  ChatUseCase.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//

import Foundation

public protocol ChatUseCase {
    func connectSocket()
    func disconnectSocket()
    func sendMessage(content: String)
    func observeMessages() -> AsyncStream<ChatEntity>
    func observeViewerCount() -> AsyncStream<Int>
}
