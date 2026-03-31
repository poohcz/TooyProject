//
//  TeacherViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import AVFoundation
import HaishinKit

public final class TeacherViewModel: ObservableObject {

    private let rtmpConnection = RTMPConnection()
    private lazy var rtmpStream = RTMPStream(connection: rtmpConnection)

    @Published public var statusMsg = "대기 중"

    public init() {
        rtmpConnection.timeout = 15
        rtmpConnection.addEventListener(.rtmpStatus, selector: #selector(rtmpStatusHandler), observer: self)
        rtmpConnection.addEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
    }

    // asyncAfter 제거 → connectSuccess 이벤트에서 publish
    @objc private func rtmpStatusHandler(_ notification: Notification) {
        guard
            let data = notification.userInfo?["data"] as? ASObject,
            let code = data["code"] as? String
        else { return }

        print("RTMP 이벤트: \(code)")

        DispatchQueue.main.async {
            switch code {
            case RTMPConnection.Code.connectSuccess.rawValue:
                self.rtmpStream.publish("test")
                self.statusMsg = "연결됨"

            case RTMPConnection.Code.connectFailed.rawValue,
                 RTMPConnection.Code.connectClosed.rawValue:
                self.statusMsg = "연결 실패"

            default:
                break
            }
        }
    }

    @objc private func rtmpErrorHandler(_ notification: Notification) {
        print("RTMP 에러: \(notification)")
        DispatchQueue.main.async {
            self.statusMsg = "연결 실패"
        }
    }

    public func startSession() {
        rtmpStream.attachCamera(
            AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        )
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio))
        rtmpStream.videoSettings.bitRate = 300 * 1000

        statusMsg = "🔄 연결 중..."
        rtmpConnection.connect("rtmp://192.168.219.100:1935/live")
        // publish는 connectSuccess에서 호출됨
    }

    public func stopSession() {
        rtmpStream.close()
        rtmpConnection.close()
        statusMsg = "대기 중"
    }

    public func getStream() -> RTMPStream {
        return rtmpStream
    }
}
