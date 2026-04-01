//
//  StudentRepositoryImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public final class StudentRepositoryImpl: StudentRepository {
    
    private let baseURL = "http://192.168.219.100:3000"
    
    public init() {}
    
    public func fetchRoomList() async throws -> [StudentEntity] {
        guard let url = URL(string: "\(baseURL)/rooms") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let dtos = try JSONDecoder().decode([StudentDTO].self, from: data)
        return dtos.map { $0.toEntity() }
    }
}
