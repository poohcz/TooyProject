//
//  RootView.swift
//  Presentation
//



import SwiftUI
import Domain

public struct RootView: View {
    @StateObject private var webRTCViewModel: WebRTCViewModel
//    @StateObject private var teacherViewModel: TeacherViewModel
//    @StateObject private var chatViewModel: ChatViewModel
//    @StateObject private var studentViewModel: StudentViewModel

    // 외부에서 이미 조립된 ViewModel들을 주입받음
    public init(
        webRTCViewModel: WebRTCViewModel
//        teacherViewModel: TeacherViewModel,
//        chatViewModel: ChatViewModel,
//        studentViewModel: StudentViewModel
    ) {
        _webRTCViewModel = StateObject(wrappedValue: webRTCViewModel)
//        _teacherViewModel = StateObject(wrappedValue: teacherViewModel)
//        _chatViewModel = StateObject(wrappedValue: chatViewModel)
//        _studentViewModel = StateObject(wrappedValue: studentViewModel)
    }

    public var body: some View {
        TabView {
            WebRTCView(viewModel: webRTCViewModel)
                .tabItem { Label("수업", systemImage: "video.fill") }
                .tag(0)

//            TeacherView(teacherViewModel: teacherViewModel, chatViewModel: chatViewModel)
//                .tabItem { Label("라이브", systemImage: "antenna.radiowaves.left.and.right") }
//                .tag(1)
//
//            StudentView(studentViewModel: studentViewModel, chatViewModel: chatViewModel)
//                .tabItem { Label("수강생", systemImage: "play.tv.fill") }
//                .tag(3)
        }
    }
}
