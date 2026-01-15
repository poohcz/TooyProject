//
//  BroadcastAPIService.swift
//  Data
//
//  Created by 김동율 on 1/15/26.
//

import Foundation


public protocol BroadcastAPIService {
    // dto에 그대로 담는거라 다른건 핑료 없음.
    func loadBroadcastList() async throws -> BroadcastListDTO
}
