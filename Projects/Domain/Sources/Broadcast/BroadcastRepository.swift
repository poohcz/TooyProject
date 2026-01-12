//
//  BroadcastRepository.swift
//  Domain
//
//  Created by enm on 1/8/26.
//

import Foundation


public protocol BroadcastRepository {
    func loadBroadcastList() async throws -> [BroadcastEntity]
}
