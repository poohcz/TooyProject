//
//  CreateRoomView.swift
//  Presentation
//
//  Created by enm on 2/11/26.
//

import SwiftUI
import WebRTC


// 일단 1:1 만들고, 추후에 1:n 가능하다면... 일단은 p2p만....................
public struct CreateRoomView: View {
    @ObservedObject var viewModel: WebRTCViewModel
    @Environment(\.dismiss) private var dismiss
    
    public init(viewModel: WebRTCViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // 1. 원격 영상 (학생 화면)
            if let remoteTrack = viewModel.remoteStreams.values.first {
                WebRTCVideoView(videoTrack: remoteTrack)
                    .ignoresSafeArea()
            } else {
                Text("학생의 입장을 기다리고 있습니다...")
                    .foregroundColor(.white)
            }
            
            // 2. 내 영상 프리뷰 (우측 상단)
            VStack {
                HStack {
                    Spacer()
                    if let localTrack = viewModel.getLocalVideoTrack() {
                        WebRTCVideoView(videoTrack: localTrack)
                            .frame(width: 120, height: 180)
                            .cornerRadius(12)
                            .padding()
                    }
                }
                Spacer()
            }
            
            // 3. 컨트롤 버튼들
            VStack {
                HStack {
                    Button("나가기") {
                        print("나갑시다")
                        viewModel.leaveRoom()
                        dismiss()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Spacer()
                }
                .padding()
                Spacer()
                HStack(spacing: 30) {
                    // 마이크 버튼
                    Button(action: { viewModel.toggleMic() }) {
                        Image(systemName: viewModel.isMicOn ? "mic.fill" : "mic.slash.fill")
                            .font(.system(size: 30))
                            .foregroundColor(viewModel.isMicOn ? .white : .red)
                    }

                    // 카메라 버튼
                    Button(action: { viewModel.toggleCamera() }) {
                        Image(systemName: viewModel.isCameraOn ? "video.fill" : "video.slash.fill")
                            .font(.system(size: 30))
                            .foregroundColor(viewModel.isCameraOn ? .white : .red)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(20)
            }
        }
        .onAppear {
            // 방에 들어가면서 방송자(강사) 권한으로 시작
            print("조인합니다.")
            viewModel.joinRoom(role: .broadcaster)
        }
    }
}


//#Preview {
//    CreateRoomView()
//}
