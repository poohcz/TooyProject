//
//  TeacherUseCaseImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain
import HaishinKit
import AVFoundation

public final class TeacherUseCaseImpl: TeacherUseCase {
    private let repository: TeacherRepository
    private let rtmpConnection = RTMPConnection()
    private lazy var rtmpStream = RTMPStream(connection: rtmpConnection)
    
    public init(repository: TeacherRepository) {
        self.repository = repository
    }
    
    public func startStream(rtmpURL: String) {
        rtmpStream.attachCamera(AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front))
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio))
        rtmpConnection.connect(rtmpURL)
    }
    
    public func stopStream() {
        rtmpStream.close()
        rtmpConnection.close()
    }
    
    public func getStreamProvider() -> StreamProvider {
        return RTMPStreamProvider(stream: rtmpStream)
    }
}
