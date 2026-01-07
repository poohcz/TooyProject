//
//  BroadcastMapper.swift
//  Data
//
//  Created by 김동율 on 1/7/26.
//

import Foundation
import Domain

protocol LiveMapperProtocol {
    func map(dto: BroadcastDTO) -> BroadcastEntity
    func map(dtoList: [BroadcastDTO]) -> [BroadcastEntity]
}

final class LiveMapper: LiveMapperProtocol {
    func map(dto: BroadcastDTO) -> BroadcastEntity {
        return BroadcastEntity(
            id: dto.id ?? "",
            title: dto.title ?? "",
            caster: dto.caster ?? ""
        )
    }
    
    func map(dtoList: [BroadcastDTO]) -> [BroadcastEntity] {
        return dtoList.map { map(dto: $0) }
    }
}
