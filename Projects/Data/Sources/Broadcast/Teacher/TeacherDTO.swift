//
//  TeacherDTO.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public struct TeacherDTO: Decodable {
    public let id: String
    public let title: String
    public let rtmpURL: String
    public let streamKey: String
}

extension TeacherDTO {
    func toEntity() -> TeacherEntity {
        TeacherEntity(
            id: id,
            title: title,
            rtmpURL: rtmpURL,
            streamKey: streamKey
        )
    }
}
