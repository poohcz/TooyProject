//
//  ChatViewModel.swift
//  Presentation
//
//  Created by 김동율 on 2/24/26.
//

import Foundation
import Combine
import SocketIO

// 메시지 데이터 모델
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isConnected: Bool = false
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    
    // 테스트용 유저 ID (본인 식별용)
    private let myUserId = UUID().uuidString

    init() {
        setupSocket()
    }

    private func setupSocket() {
        // 서버 주소 (시뮬레이터 기준, 실기기는 Mac의 IP 주소로 변경)
        guard let url = URL(string: "http://192.168.219.100:3000") else { return }
        
        manager = SocketManager(socketURL: url, config: [.log(false), .compress])
        socket = manager.defaultSocket
        
        // 연결 성공
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket connected!")
            DispatchQueue.main.async {
                self?.isConnected = true
            }
        }
        
        // 연결 끊김
        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            print("Socket disconnected!")
            DispatchQueue.main.async {
                self?.isConnected = false
            }
        }
        
        // 메시지 수신 (서버에서 'chatMessage' 이벤트로 보낸 데이터)
        socket.on("chatMessage") { [weak self] data, ack in
            guard let self = self,
                  let messageData = data[0] as? [String: Any],
                  let senderId = messageData["senderId"] as? String,
                  let text = messageData["text"] as? String else { return }
            
            // 내가 보낸 메시지가 아닐 때만 수신
            if senderId != self.myUserId {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(text: text, isMe: false))
                }
            }
        }
        
        socket.connect()
    }

    func sendMessage(text: String) {
        guard !text.isEmpty else { return }

        // 서버로 보낼 데이터 형식
        let messageData: [String: Any] = [
            "senderId": myUserId,
            "text": text
        ]

        // 서버로 메시지 전송
        socket.emit("chatMessage", messageData)

        // 내 화면에 메시지 추가
        DispatchQueue.main.async {
            self.messages.append(ChatMessage(text: text, isMe: true))
        }
    }
    
    deinit {
        socket.disconnect()
    }
}
