//
//  MyApp.swift
//  Presentation
//
//  Created by 김동율 on 2/4/26.
//

import SwiftUI
import Presentation
import Domain

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                webRTCViewModel: DIContainer.shared.makeWebRTCViewModel()
//                teacherViewModel: DIContainer.shared.makeTeacherViewModel(),
//                chatViewModel: DIContainer.shared.makeChatViewModel(),
//                studentViewModel: DIContainer.shared.makeStudentViewModel()
            )
        }
    }
}
