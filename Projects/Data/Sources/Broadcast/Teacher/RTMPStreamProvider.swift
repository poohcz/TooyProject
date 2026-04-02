//
//  RTMPStreamProvider.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import HaishinKit
import Domain

public struct RTMPStreamProvider: StreamProvider {
    private let stream: RTMPStream

    public init(stream: RTMPStream) {
        self.stream = stream
    }

    public func attach(to view: Any) {
        if let mthkView = view as? MTHKView {
            mthkView.attachStream(stream)
        }
    }
}
