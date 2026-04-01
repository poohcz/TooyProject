//
//  ChatRepository.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



public protocol ChatRepository {
    func connect()
    func disconnect()
    func sendMessage(content: String)
    func observeMessages() -> AsyncStream<ChatEntity>
    func observeViewerCount() -> AsyncStream<Int>
}

