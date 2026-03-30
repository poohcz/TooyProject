//
//  StudentView.swift
//  Presentation
//
//  Created by 김동율 on 3/5/26.
//

//let testURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!


// StudentView.swift
import SwiftUI

struct StudentView: View {
    @StateObject private var viewModel: StudentViewModel

    init(viewModel: StudentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Text("수강생 라이브 화면")
                .font(.headline)
                .padding()

            if let player = viewModel.player {
                CustomStudentPlayer(player: player)
                    .frame(height: 250)
            } else {
                ProgressView("방송 연결 중...")
            }

            Spacer()

            Text("영상이 재생되면, 아이폰 화면을 위로 쓸어올려 홈으로 나가보세요!\n(재생 버튼도 사라졌을 겁니다!)")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
    }
}
