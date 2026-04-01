//
//  TeacherView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI

public struct TeacherView: View {

    @StateObject private var teacherViewModel: TeacherViewModel
    @StateObject private var chatViewModel: ChatViewModel

    public init(teacherViewModel: TeacherViewModel, chatViewModel: ChatViewModel) {
        _teacherViewModel = StateObject(wrappedValue: teacherViewModel)
        _chatViewModel = StateObject(wrappedValue: chatViewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            // 카메라 프리뷰 영역
            ZStack(alignment: .topLeading) {
                TeacherPlayerView(stream: teacherViewModel.getStream())
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                    .ignoresSafeArea(edges: .top)

                // 방송 상태
                HStack(spacing: 6) {
                    Circle()
                        .fill(teacherViewModel.isStreaming ? Color.red : Color.gray)
                        .frame(width: 8, height: 8)
                    Text(teacherViewModel.statusMsg)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.black.opacity(0.6))
                .cornerRadius(8)
                .padding(.top, 60)
                .padding(.leading, 16)

                // 시청자 수
                HStack(spacing: 4) {
                    Image(systemName: "eye.fill")
                    Text("\(chatViewModel.viewerCount)")
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.black.opacity(0.6))
                .cornerRadius(8)
                .padding(.top, 60)
                .padding(.leading, 120)
            }

            // 채팅 - StudentView랑 동일한 ChatView 재사용
            ChatView(viewModel: chatViewModel)
        }
        .onAppear { teacherViewModel.startSession() }
        .onDisappear { teacherViewModel.stopSession() }
    }
}
