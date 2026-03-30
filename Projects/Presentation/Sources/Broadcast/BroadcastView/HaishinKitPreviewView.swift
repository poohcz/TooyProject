//
//  HaishinKitPreviewView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI
import HaishinKit

public struct HaishinKitPreviewView: UIViewRepresentable {
    
    let stream: RTMPStream
    
    public init(stream: RTMPStream) {
        self.stream = stream
    }
    
    public func makeUIView(context: Context) -> MTHKView {
        let view = MTHKView(frame: .zero)
        view.videoGravity = .resizeAspectFill
        view.attachStream(stream)
        
        return view
    }
    
    public func updateUIView(_ uiView: MTHKView, context: Context) {}
}
