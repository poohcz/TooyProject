//
//  BroadcastEntity.swift
//  Domain
//
//  Created by 김동율 on 3/31/26.
//

import Foundation

public struct BroadcastEntity {
    public let title: String
    public let casterId: String

    public init(title: String, casterId: String) {
        self.title = title
        self.casterId = casterId
    }
}
