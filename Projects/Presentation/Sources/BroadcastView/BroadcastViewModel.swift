//
//  BroadcastViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import AVFoundation
import HaishinKit

public final class BroadcastViewModel: ObservableObject {
    
    //MARK: - 객체들
    private let rtmpConnection = RTMPConnection()
    // lazy로 했는데 rtmpConnection이 바로안들어감. viewmodel호출후에 바로 객체생성할필요도 없기도하고해서 lazy로 함. 실제 코딩에서 사용잘 안했는데... lazy로 하니간 객체를 바로 넣을수 있다는점에서 하나 또 배움.
    private lazy var rtmpStream = RTMPStream(connection: rtmpConnection)
    
    //MARK: - 어노테이션
    @Published public var statusMsg = "대기 중"
    
    
    public init() {
        rtmpConnection.timeout = 15
        
        rtmpConnection.addEventListener(.rtmpStatus, selector: #selector(rtmpStatusHandler), observer: self)
        rtmpConnection.addEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
    }
    
    @objc private func rtmpStatusHandler(_ notification: Notification) {
        print(" RTMP 이벤트: \(notification)")
        DispatchQueue.main.async {
            self.statusMsg = "연결됨"
        }
    }
    
    @objc private func rtmpErrorHandler(_ notification: Notification) {
        print("RTMP 에러: \(notification)")
        DispatchQueue.main.async {
            self.statusMsg = "연결 실패"
        }
    }

    public func startSession() {
        rtmpStream.attachCamera(AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front))
        
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio))
        
        rtmpStream.videoSettings.bitRate = 300 * 1000
        
        print("RTMP 연결 시도")
        statusMsg = "🔄 연결 중..."
        
        rtmpConnection.connect("rtmp://192.168.219.100:1935/live")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("publish 시작")
            self.rtmpStream.publish("test")
        }
    }

    public func stopSession() {
        print("중지")
        rtmpStream.close()
        rtmpConnection.close()
        statusMsg = "대기 중"
    }
    
    public func getStream() -> RTMPStream {
        return rtmpStream
    }
}
