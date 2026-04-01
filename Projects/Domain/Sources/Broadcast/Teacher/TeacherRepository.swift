//
//  TeacherRepository.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



public protocol TeacherRepository {
    func createRoom(title: String) async throws -> TeacherEntity
}
