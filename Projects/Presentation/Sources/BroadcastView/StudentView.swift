//
//  StudentView.swift
//  Presentation
//
//  Created by 김동율 on 3/5/26.
//

import SwiftUI
import AVKit

struct StudentView: View {
    let testURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    
    @State private var player: AVPlayer?
    
    var body: some View {
        VStack {
            Text("수강생 라이브 화면")
                .font(.headline)
                .padding()
            
            if let player = player {
                CustomStudentPlayer(player: player)
                    .frame(height: 250)
                    .onAppear {
                        setupAudioSession()
                        player.play()
                    }
            } else {
                ProgressView("방송 연결 중...")
            }
            
            Spacer()
            
            Text("영상이 재생되면, 아이폰 화면을 위로 쓸어올려 홈으로 나가보세요!\n(재생 버튼도 사라졌을 겁니다!)")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear {
            self.player = AVPlayer(url: testURL)
        }
    }
    
    // 오디오 세팅 코드는 아까와 동일합니다.
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("오디오 세션 세팅 실패: \(error.localizedDescription)")
        }
    }
}
