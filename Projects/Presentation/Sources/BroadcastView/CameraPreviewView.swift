//
//  CameraPreviewView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import AVFoundation

public struct CameraPreviewView: UIViewRepresentable {

    public let session: AVCaptureSession

    public init(session: AVCaptureSession) {
        self.session = session
    }

    
    // 세션연결되면 자동렌더링 중요!
    public func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        
        return view
    }

    public func updateUIView(_ uiView: PreviewView, context: Context) {}
}

public final class PreviewView: UIView {
    public override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    public var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }
}
