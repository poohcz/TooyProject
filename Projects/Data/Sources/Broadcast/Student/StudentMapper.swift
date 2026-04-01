//
//  StudentMapper.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public struct StudentMapper {
    public static func toEntity(_ dto: StudentDTO) -> StudentEntity {
        StudentEntity(
            id: dto.id,
            title: dto.title,
            hlsURL: dto.hlsURL,
            viewerCount: dto.viewerCount
        )
    }
}
