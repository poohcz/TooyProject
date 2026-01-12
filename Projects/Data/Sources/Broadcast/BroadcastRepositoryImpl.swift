//
//  BroadcastRepositoryImpl.swift
//  Data
//
//  Created by enm on 1/12/26.
//

import Foundation
import Domain


public final class BroadcastRepositoryImpl: BroadcastRepository {

    private let apiService: BroadcastAPIService
    private let mapper: BroadcastMapperProtocol

    public init() {
        self.apiService = BroadcastAPIServiceImpl()
        self.mapper = BroadcastMapper()
    }
    
    public func loadBroadcastList() async throws -> [Domain.BroadcastEntity] {
        let dto = try await apiService.loadBroadcastList()
        return mapper.map(dtoList: dto.broadcastList)
    }

}

