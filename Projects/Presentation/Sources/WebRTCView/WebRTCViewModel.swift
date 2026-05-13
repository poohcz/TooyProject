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
    private var joinTask: Task<Void, Never>?

    public var remoteParticipantIDs: [String] {
        Array(remoteStreams.keys)
    }

    public enum RoomLayout {
        case empty(local: (any VideoTrack)?)
        case oneToOne(remote: any VideoTrack, local: (any VideoTrack)?)
        case oneToTwo(remotes: [any VideoTrack], local: (any VideoTrack)?)
    }

    public var layout: RoomLayout {
        // ✅ 최대 2명으로 제한
        let remotes = remoteParticipantIDs.prefix(2).compactMap { remoteStreams[$0] }
        switch remotes.count {
        case 0: return .empty(local: localVideoTrack)
        case 1: return .oneToOne(remote: remotes[0], local: localVideoTrack)
        default: return .oneToTwo(remotes: Array(remotes), local: localVideoTrack)
        }
    }

    public init(useCase: WebRTCUseCase) {
        self.useCase = useCase
    }

    public func joinRoom(role: UserRole) {
        joinTask?.cancel()
        joinTask = Task {
            for await event in await useCase.executeJoin(role: role) {
                guard !Task.isCancelled else { break }
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
        joinTask?.cancel()
        joinTask = nil
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
