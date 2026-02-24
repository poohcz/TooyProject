//
//  ChatView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI

// 1. 메시지 모델
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool // 내가 보낸 건지, 상대방이 보낸 건지 구분
}

struct ChatView: View {
    // 2. 상태 관리 (입력창 텍스트와 임시 메시지 목록)
    @State private var inputText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "안녕하세요, 선생님!", isMe: false),
        ChatMessage(text: "네 율 브로, 반가워요! 어떤 문제가 어렵나요?", isMe: true)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 3. 채팅 내역 스크롤 영역
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { msg in
                        ChatBubble(message: msg)
                    }
                }
                .padding()
            }
            .onTapGesture {
                // 바탕을 누르면 키보드가 내려가게 합니다.
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            // 4. 하단 메시지 입력 영역
            HStack {
                TextField("메시지를 입력하세요...", text: $inputText)
                    .padding(10)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(20)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill") // 비행기 모양 전송 아이콘
                        .font(.system(size: 22))
                        .foregroundColor(!inputText.isEmpty ? .blue : .gray)
                }
                .disabled(inputText.isEmpty) // 빈 칸일 땐 버튼 비활성화
            }
            .padding()
            .background(Color.white)
        }
        .navigationTitle("실시간 채팅")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 5. 메시지 전송 로직
    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        let newMessage = ChatMessage(text: inputText, isMe: true)
        messages.append(newMessage)
        inputText = ""
    }
}

// 6. 말풍선 컴포넌트
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isMe { Spacer() }
            
            Text(message.text)
                .padding(12)
                .background(message.isMe ? Color.blue : Color(uiColor: .systemGray5))
                .foregroundColor(message.isMe ? .white : .black)
                .cornerRadius(16)
            
            if !message.isMe { Spacer() }
        }
    }
}

#Preview {
    ChatView()
}
