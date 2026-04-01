//
//  StudentView.swift
//  Presentation
//
//  Created by 김동율 on 3/5/26.
//

//let testURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!


import SwiftUI

struct StudentView: View {
    @StateObject private var studentViewModel: StudentViewModel
    @StateObject private var chatViewModel: ChatViewModel
    
    init(studentViewModel: StudentViewModel, chatViewModel: ChatViewModel) {
        _studentViewModel = StateObject(wrappedValue: studentViewModel)
        _chatViewModel = StateObject(wrappedValue: chatViewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                if let player = studentViewModel.player {
                    StudentPlayerView(player: player)
                        .frame(height: UIScreen.main.bounds.height * 0.45)
                } else {
                    ZStack {
                        Color.black
                        ProgressView("방송 연결 중...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "eye.fill")
                    Text("\(chatViewModel.viewerCount)")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.black.opacity(0.6))
                .cornerRadius(8)
                .padding(12)
            }
            
            ChatView(viewModel: chatViewModel)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear { studentViewModel.onAppear() }
        .onDisappear { studentViewModel.onDisappear() }
    }
}
