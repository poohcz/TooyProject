//
//  BroadcastUseCase.swift
//  Domain
//
//  Created by 김동율 on 1/7/26.
//


import Foundation

public protocol BroadcastUseCase {

    func execute() async throws -> [BroadcastEntity]
}
