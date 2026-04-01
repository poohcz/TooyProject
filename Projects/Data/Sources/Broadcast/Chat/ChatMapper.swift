//
//  ChatMapper.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public struct ChatMapper {
    public static func toEntity(_ dto: ChatDTO) -> ChatEntity {
        ChatEntity(
            sender: dto.sender,
            content: dto.content
        )
    }
}
