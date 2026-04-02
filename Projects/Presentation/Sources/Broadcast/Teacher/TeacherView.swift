//
//  TeacherView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import Domain

public struct TeacherView: View {
    @StateObject private var teacherViewModel: TeacherViewModel
    @StateObject private var chatViewModel: ChatViewModel

    
    public init(teacherViewModel: TeacherViewModel, chatViewModel: ChatViewModel) {
        _teacherViewModel = StateObject(wrappedValue: teacherViewModel)
        _chatViewModel = StateObject(wrappedValue: chatViewModel)
    }

    public var body: some View {
        ZStack {
            TeacherPlayerView(stream: teacherViewModel.getStream())
                .ignoresSafeArea()

            VStack {
                HStack(spacing: 12) {
                    statusBadge
                    viewerBadge
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)

                Spacer()

                VStack(spacing: 0) {
                    ChatView(viewModel: chatViewModel)
                        .frame(height: 250)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(15)
                        .padding()

                    controlBar
                }
            }
        }
        .onDisappear { teacherViewModel.stopSession() }
    }

    private var statusBadge: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(teacherViewModel.isStreaming ? Color.red : Color.gray)
                .frame(width: 8, height: 8)
            Text(teacherViewModel.statusMsg)
                .font(.system(size: 12, weight: .bold))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .foregroundColor(.white)
    }

    private var viewerBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: "eye.fill")
            Text("\(chatViewModel.viewerCount)")
        }
        .font(.system(size: 12, weight: .bold))
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.black.opacity(0.4))
        .cornerRadius(20)
        .foregroundColor(.white)
    }

    private var controlBar: some View {
        HStack {
            Button(action: {
                teacherViewModel.isStreaming ? teacherViewModel.stopSession() : teacherViewModel.startSession()
            }) {
                HStack {
                    Image(systemName: teacherViewModel.isStreaming ? "stop.fill" : "play.fill")
                    Text(teacherViewModel.isStreaming ? "방송 종료" : "방송 시작")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(teacherViewModel.isStreaming ? Color.red.opacity(0.8) : Color.blue)
                .cornerRadius(15)
            }
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.8))
    }
}
