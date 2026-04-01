//
//  ChatRepositoryImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain
import SocketIO

public class ChatRepositoryImpl: ChatRepository {
    
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    private var messageContinuation: AsyncStream<ChatEntity>.Continuation?
    private var viewerCountContinuation: AsyncStream<Int>.Continuation?
    
    public init() {
        guard let url = URL(string: "http://192.168.219.100:3000") else { return }
        socketManager = SocketManager(socketURL: url, config: [.log(false), .compress])
        socket = socketManager.defaultSocket
        
        socket.on("chat_message") { [weak self] data, _ in
            guard let dict = data[0] as? [String: Any],
                  let sender = dict["sender"] as? String,
                  let content = dict["content"] as? String else { return }
            let entity = ChatEntity(sender: sender, content: content)
            self?.messageContinuation?.yield(entity)
        }
        
        socket.on("viewer_count") { [weak self] data, _ in
            guard let count = data[0] as? Int else { return }
            self?.viewerCountContinuation?.yield(count)
        }
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    public func sendMessage(content: String) {
        socket.emit("chat_message", ["content": content])
    }
    
    public func observeMessages() -> AsyncStream<ChatEntity> {
        AsyncStream { continuation in
            self.messageContinuation = continuation
        }
    }
    
    public func observeViewerCount() -> AsyncStream<Int> {
        AsyncStream { continuation in
            self.viewerCountContinuation = continuation
        }
    }
}
