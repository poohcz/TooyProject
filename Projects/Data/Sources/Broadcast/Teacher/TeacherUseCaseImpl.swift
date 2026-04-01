//
//  TeacherUseCaseImpl.swift
//  Data
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain

public final class TeacherUseCaseImpl: TeacherUseCase {
    
    private let repository: TeacherRepository
    
    public init(repository: TeacherRepository) {
        self.repository = repository
    }
    
    public func startStream(rtmpURL: String) {
        
    }
    
    public func stopStream() {
        
    }
}
