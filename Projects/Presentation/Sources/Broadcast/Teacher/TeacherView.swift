//
//  TeacherView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI

public struct TeacherView: View {

    @StateObject private var viewModel: TeacherViewModel

    public init(viewModel: TeacherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        CustomTeacherPlayer(stream: viewModel.getStream())
            .ignoresSafeArea()
            .onAppear {
                viewModel.startSession()
            }
            .onDisappear {
                viewModel.stopSession()
            }
    }
}
