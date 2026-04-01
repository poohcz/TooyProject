//
//  StudentRepository.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



public protocol StudentRepository {
    func fetchRoomList() async throws -> [StudentEntity]
}
