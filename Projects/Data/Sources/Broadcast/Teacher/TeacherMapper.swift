//
//  TeacherMapper.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public struct TeacherMapper {
    public static func toEntity(_ dto: TeacherDTO) -> TeacherEntity {
        TeacherEntity(
            id: dto.id,
            title: dto.title,
            rtmpURL: dto.rtmpURL,
            streamKey: dto.streamKey
        )
    }
}
