//
//  CreateRoomView.swift
//  Presentation
//
//  Created by enm on 2/11/26.
//

import SwiftUI

public struct CreateRoomView: View {
    @ObservedObject var viewModel: WebRTCViewModel
    @Environment(\.dismiss) private var dismiss

    public init(viewModel: WebRTCViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        StudentView(participantIDs: viewModel.remoteParticipantIDs)
            .background(Color.black)
            .ignoresSafeArea()
            
            .overlay(alignment: .topTrailing) {
                TeacherView(track: viewModel.getLocalVideoTrack())
                    .padding(.top, 50)
                    .padding(.trailing, 16)
            }

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
        let participantIDs: [String]

        var body: some View {
            // 추후 ForEach(participantIDs)로 영상 렌더링
            Color.black
        }
    }

    struct TeacherView: View {
        let teacherID: String?

        var body: some View {
            // 추후 teacherID로 로컬 영상 렌더링
            Color.blue
                .frame(width: 120, height: 180)
                .cornerRadius(12)
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
                }

                Button(action: onToggleCamera) {
                    Image(systemName: isCameraOn ? "video.fill" : "video.slash.fill")
                }

                Button(action: onLeave) {
                    Image(systemName: "phone.down.fill")
                }
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(20)
            .padding(.bottom, 50)
        }
    }
}
