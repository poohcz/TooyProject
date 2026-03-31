//
//  RTMPStreamProvider.swift
//  Data
//
//  Created by enm on 3/31/26.
//


import HaishinKit

public final class RTMPStreamProvider: StreamProvider {
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
