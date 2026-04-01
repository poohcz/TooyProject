//
//  TeacherViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import Foundation
import AVFoundation
import HaishinKit
import Domain

@MainActor
public class TeacherViewModel: ObservableObject {

    @Published public var isStreaming: Bool = false
    @Published public var statusMsg: String = "대기 중"

    private let rtmpConnection = RTMPConnection()
    private lazy var rtmpStream = RTMPStream(connection: rtmpConnection)

    public init() {
        rtmpConnection.timeout = 15
        rtmpConnection.addEventListener(.rtmpStatus, selector: #selector(rtmpStatusHandler), observer: self)
        rtmpConnection.addEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
    }

    @objc private func rtmpStatusHandler(_ notification: Notification) {
        guard
            let data = notification.userInfo?["data"] as? ASObject,
            let code = data["code"] as? String
        else { return }

        switch code {
        case RTMPConnection.Code.connectSuccess.rawValue:
            rtmpStream.publish("test")
            isStreaming = true
            statusMsg = "방송 중"
        case RTMPConnection.Code.connectFailed.rawValue,
             RTMPConnection.Code.connectClosed.rawValue:
            isStreaming = false
            statusMsg = "연결 실패"
        default:
            break
        }
    }

    @objc private func rtmpErrorHandler(_ notification: Notification) {
        isStreaming = false
        statusMsg = "연결 실패"
    }

    public func startSession() {
        rtmpStream.attachCamera(
            AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        )
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio))
        rtmpStream.videoSettings.bitRate = 300 * 1000
        statusMsg = "연결 중..."
        rtmpConnection.connect("rtmp://192.168.219.100:1935/live")
    }

    public func stopSession() {
        rtmpStream.close()
        rtmpConnection.close()
        isStreaming = false
        statusMsg = "대기 중"
    }

    public func getStream() -> RTMPStream {
        return rtmpStream
    }
}
