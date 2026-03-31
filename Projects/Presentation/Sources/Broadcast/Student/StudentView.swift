//
//  StudentView.swift
//  Presentation
//
//  Created by 김동율 on 3/5/26.
//

//let testURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!


import SwiftUI

struct StudentView: View {
    @StateObject private var viewModel: StudentViewModel

    init(viewModel: StudentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("수강생 라이브 화면")
                .font(.headline)
                .padding()

            Group {
                if let player = viewModel.player {
                    CustomStudentPlayer(player: player)
                        .frame(height: 250)
                        .background(Color.black)
                } else {
                    ZStack {
                        Color.black.frame(height: 250)
                        ProgressView("방송 연결 중...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                    }
                }
            }

            Spacer()

            VStack(spacing: 10) {
                Text("4444")
                    .font(.subheadline)
                    .bold()
                
                Text("123123")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
    }
}
