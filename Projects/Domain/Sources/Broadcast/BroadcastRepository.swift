//
//  BroadcastRepository.swift
//  Domain
//
//  Created by 김동율 on 3/31/26.
//

import Foundation

public protocol BroadcastRepository {
    func loadBroadcastList() async throws -> [BroadcastEntity]
}
