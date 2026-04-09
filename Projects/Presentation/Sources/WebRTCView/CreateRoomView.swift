//
//  CreateRoomView.swift
//  Presentation
//
//  Created by 김동율 on 2/11/26.
//

import SwiftUI

public struct CreateRoomView: View {
    @ObservedObject var viewModel: WebRTCViewModel
    @Environment(\.dismiss) private var dismiss

    public init(viewModel: WebRTCViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        StudentView(layout: viewModel.layout)
            .background(Color.black)
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ControlPad(
                    isMicOn: viewModel.isMicOn,
                    isCameraOn: viewModel.isCameraOn,
                    onToggleMic: { viewModel.toggleMic() },
                    onToggleCamera: { viewModel.toggleCamera() },
                    onLeave: {
                        viewModel.leaveRoom()
                        dismiss()
                    }
                )
            }
            .onAppear {
                viewModel.joinRoom(role: .broadcaster)
            }
    }
}

// MARK: - Subviews
extension CreateRoomView {

    struct StudentView: View {
        let layout: WebRTCViewModel.RoomLayout

        var body: some View {
            switch layout {
            case .empty(let local):
                if let local {
                    WebRTCVideoView(videoTrack: local)
                        .ignoresSafeArea()
                } else {
                    Color.black
                }

            case .oneToOne(let remote, let local):
                ZStack(alignment: .topTrailing) {
                    WebRTCVideoView(videoTrack: remote)
                        .ignoresSafeArea()
                    if let local {
                        WebRTCVideoView(videoTrack: local)
                            .frame(width: 100, height: 150)
                            .cornerRadius(12)
                            .padding(.top, 60)
                            .padding(.trailing, 16)
                    }
                }

            case .oneToTwo(let remotes, let local):
                VStack(spacing: 2) {
                    if let local {
                        WebRTCVideoView(videoTrack: local)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Color.black
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    HStack(spacing: 2) {
                        ForEach(remotes.indices, id: \.self) { i in
                            WebRTCVideoView(videoTrack: remotes[i])
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.35)
                }
                .ignoresSafeArea()
            }
        }
    }

    struct ControlPad: View {
        let isMicOn: Bool
        let isCameraOn: Bool
        let onToggleMic: () -> Void
        let onToggleCamera: () -> Void
        let onLeave: () -> Void

        var body: some View {
            HStack(spacing: 40) {
                Button(action: onToggleMic) {
                    Image(systemName: isMicOn ? "mic.fill" : "mic.slash.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Button(action: onToggleCamera) {
                    Image(systemName: isCameraOn ? "video.fill" : "video.slash.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Button(action: onLeave) {
                    Image(systemName: "phone.down.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(20)
            .padding(.bottom, 50)
        }
    }
}
