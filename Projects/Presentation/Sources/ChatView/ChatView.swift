//
//  ChatView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // 연결 상태 표시
            if !viewModel.isConnected {
                Text("서버 연결 중...")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            
            // 채팅 내역
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { msg in
                        ChatBubble(message: msg)
                    }
                }
                .padding()
            }
            .onTapGesture {
                // 키보드 내리기
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            // 메시지 입력 및 전송
            HStack {
                TextField("메시지를 입력하세요...", text: $inputText)
                    .padding(10)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(20)
                
                Button(action: {
                    viewModel.sendMessage(text: inputText)
                    inputText = ""
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundColor(inputText.isEmpty ? .gray : .blue)
                }
                .disabled(inputText.isEmpty)
            }
            .padding()
            .background(Color.white)
        }
        .navigationTitle("실시간 채팅")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 말풍선 UI
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
    NavigationView {
        ChatView()
    }
}
