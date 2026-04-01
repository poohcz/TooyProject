//
//  StudentDTO.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public struct StudentDTO: Decodable {
    public let id: String
    public let title: String
    public let hlsURL: String
    public let viewerCount: Int
}

extension StudentDTO {
    func toEntity() -> StudentEntity {
        StudentEntity(
            id: id,
            title: title,
            hlsURL: hlsURL,
            viewerCount: viewerCount
        )
    }
}
