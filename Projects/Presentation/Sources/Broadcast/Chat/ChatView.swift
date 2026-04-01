//
//  ChatView.swift
//  Presentation
//
//  Created by 김동율 on 4/1/26.
//


import SwiftUI
import Domain


public struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    public var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message: message)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let last = viewModel.messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }
            
            Divider()
            
            HStack(spacing: 8) {
                TextField("채팅 입력...", text: $viewModel.chatInput)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.send)
                    .onSubmit { viewModel.sendChat() }
                
                Button(action: viewModel.sendChat) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
    }
    
    struct ChatBubble: View {
        let message: ChatEntity
        
        var body: some View {
            HStack(alignment: .top, spacing: 6) {
                Text(message.sender)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text(message.content)
                    .font(.caption)
            }
            .id(message.id)
        }
    }
}
