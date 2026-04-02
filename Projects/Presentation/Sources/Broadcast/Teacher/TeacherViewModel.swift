//
//  TeacherViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import Foundation
import Domain
import Combine

@MainActor
public class TeacherViewModel: ObservableObject {
    @Published public var isStreaming: Bool = false
    @Published public var statusMsg: String = "대기 중"
    
    private let useCase: TeacherUseCase
    private let streamProvider: StreamProvider

    public init(useCase: TeacherUseCase) {
        self.useCase = useCase
        self.streamProvider = useCase.getStreamProvider()
    }

    public func getStream() -> StreamProvider {
        return streamProvider
    }

    public func startSession() {
        statusMsg = "연결 중..."
        useCase.startStream(rtmpURL: "rtmp://192.168.219.100:1935/live")
        isStreaming = true
        statusMsg = "방송 중"
    }

    public func stopSession() {
        useCase.stopStream()
        isStreaming = false
        statusMsg = "대기 중"
    }
}
