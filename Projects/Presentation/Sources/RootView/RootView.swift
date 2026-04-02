//
//  RootView.swift
//  Presentation
//



import SwiftUI
import Domain
import Data

public struct RootView: View {
    @StateObject private var webRTCViewModel: WebRTCViewModel
    @StateObject private var teacherViewModel: TeacherViewModel
    @StateObject private var chatViewModel: ChatViewModel
    @StateObject private var studentViewModel: StudentViewModel

    public init() {
        // WebRTC
        let manager = WebRTCManager()
        let webRTCUseCase = WebRTCUseCaseImpl(webRTCManager: manager)
        _webRTCViewModel = StateObject(wrappedValue: WebRTCViewModel(useCase: webRTCUseCase))

        // Teacher
        let teacherRepository = TeacherRepositoryImpl()
        let teacherUseCase = TeacherUseCaseImpl(repository: teacherRepository)
        _teacherViewModel = StateObject(wrappedValue: TeacherViewModel(useCase: teacherUseCase))

        // Chat
        _chatViewModel = StateObject(wrappedValue: ChatViewModel())

        // Student
        let studentUseCase = StudentUseCaseImpl()
        let streamURL = URL(string: "http://192.168.219.100:8080/live/test.m3u8")!
        _studentViewModel = StateObject(wrappedValue: StudentViewModel(useCase: studentUseCase, streamURL: streamURL))
    }

    public var body: some View {
        TabView {
            WebRTCView(viewModel: webRTCViewModel)
                .tabItem { Label("수업", systemImage: "video.fill") }
                .tag(0)

            TeacherView(teacherViewModel: teacherViewModel, chatViewModel: chatViewModel)
                .tabItem { Label("라이브", systemImage: "antenna.radiowaves.left.and.right") }
                .tag(1)

            StudentView(studentViewModel: studentViewModel, chatViewModel: chatViewModel)
                .tabItem { Label("수강생", systemImage: "play.tv.fill") }
                .tag(3)
        }
    }
}
