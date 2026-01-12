//
//  BroadcastAPIService.swift
//  Data
//
//  Created by enm on 1/12/26.
//

import Foundation

public protocol BroadcastAPIService {
    // dto에 그대로 담는거라 다른건 핑료 없음.
    func loadBroadcastList() async throws -> BroadcastListDTO
}

// api연결전 더미데이터
public final class BroadcastAPIServiceImpl: BroadcastAPIService {
    public init() {}
    
    public func loadBroadcastList() async throws -> BroadcastListDTO {
        return BroadcastListDTO(
            broadcastList: [
                BroadcastDTO(
                    title: "일번테스트",
                    casterId: "firstId",
                    viewers: 123,
                    liveStatus: true
                ),
                BroadcastDTO(
                    title: nil,
                    casterId: "secondId",
                    viewers: 45,
                    liveStatus: true
                )
            ]
        )
    }
}



