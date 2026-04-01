//
//  ChatUseCaseImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public final class ChatUseCaseImpl: ChatUseCase {
    
    private let repository: ChatRepository
    
    public init(repository: ChatRepository) {
        self.repository = repository
    }
    
    public func connectSocket() {
        repository.connect()
    }
    
    public func disconnectSocket() {
        repository.disconnect()
    }
    
    public func sendMessage(content: String) {
        repository.sendMessage(content: content)
    }
    
    public func observeMessages() -> AsyncStream<ChatEntity> {
        repository.observeMessages()
    }
    
    public func observeViewerCount() -> AsyncStream<Int> {
        repository.observeViewerCount()
    }
    
}
