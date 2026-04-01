//
//  ChatEntity.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//

import Foundation

public struct ChatEntity: Identifiable {
    public let id: UUID
    public let sender: String
    public let content: String
    public let timestamp: Date

    public init(sender: String, content: String) {
        self.id = UUID()
        self.sender = sender
        self.content = content
        self.timestamp = Date()
    }
}
