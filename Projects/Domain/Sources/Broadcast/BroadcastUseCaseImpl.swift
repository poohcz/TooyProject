//
//  BroadcastUseCaseImpl.swift
//  Domain
//
//  Created by 김동율 on 1/7/26.
//

import Foundation

public final class BroadcastUseCaseImpl: BroadcastUseCase {
    
    private let repository: BroadcastRepository
    
    public init(repository: BroadcastRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [BroadcastEntity] {
        try await repository.loadBroadcastList()
    }
    
}

