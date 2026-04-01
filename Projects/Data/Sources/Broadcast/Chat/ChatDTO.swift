//
//  ChatDTO.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation

public struct ChatDTO: Decodable {
    public let sender: String
    public let content: String
    public let timestamp: String
}
