//
//  TeacherRepositoryImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public final class TeacherRepositoryImpl: TeacherRepository {
    
    private let baseURL = "http://192.168.219.100:3000"
    
    public init() {}
    
    public func createRoom(title: String) async throws -> TeacherEntity {
        guard let url = URL(string: "\(baseURL)/rooms") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(["title": title])
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let dto = try JSONDecoder().decode(TeacherDTO.self, from: data)
        return dto.toEntity()
    }
}
