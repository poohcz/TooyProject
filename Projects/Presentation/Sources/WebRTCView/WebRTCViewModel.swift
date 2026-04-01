//
//  WebRTCViewModel.swift
//  Presentation
//
//  Created by 김동율 on 2/11/26.
//

import Foundation
import Domain

@MainActor
public class WebRTCViewModel: ObservableObject {

    @Published public var localVideoTrack: (any VideoTrack)?
    @Published public var remoteStreams: [String: any VideoTrack] = [:]
    @Published public var isMicOn: Bool = true
    @Published public var isCameraOn: Bool = true

    private let useCase: WebRTCUseCase

    public var remoteParticipantIDs: [String] {
        Array(remoteStreams.keys)
    }

    public enum RoomLayout {
        case empty
        case oneToOne(remote: any VideoTrack, local: (any VideoTrack)?)
        case oneToTwo(remotes: [any VideoTrack], local: (any VideoTrack)?)
    }

    public var layout: RoomLayout {
        switch remoteStreams.count {
        case 0:
            return .empty
        case 1:
            let track = remoteStreams.values.first!
            return .oneToOne(remote: track, local: localVideoTrack)
        default:
            let tracks = remoteParticipantIDs.compactMap { remoteStreams[$0] }
            return .oneToTwo(remotes: tracks, local: localVideoTrack)
        }
    }

    public init(useCase: WebRTCUseCase) {
        self.useCase = useCase
    }

    public func joinRoom(role: UserRole) {
        Task {
            for await event in await useCase.executeJoin(role: role) {
                switch event {
                case .localVideoTrackReady(let track):
                    self.localVideoTrack = track
                case .videoTrackAdded(let id, let track):
                    self.remoteStreams[id] = track
                case .videoTrackRemoved(let id):
                    self.remoteStreams.removeValue(forKey: id)
                case .peerLeft(let id):
                    self.remoteStreams.removeValue(forKey: id)
                case .error(let message):
                    print("에러: \(message)")
                default:
                    break
                }
            }
        }
    }

    public func leaveRoom() {
        useCase.executeLeave()
    }

    public func toggleMic() {
        isMicOn.toggle()
        useCase.controlAudio(isOn: isMicOn)
    }

    public func toggleCamera() {
        isCameraOn.toggle()
        useCase.controlVideo(isOn: isCameraOn)
    }
}
