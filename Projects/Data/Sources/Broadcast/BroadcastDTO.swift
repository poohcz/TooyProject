//
//  BroadcastDTO.swift
//  Data
//
//  Created by 김동율 on 1/7/26.
//

import Foundation

// 일부러 옵셔널로 줌. 그리고 entity로 사용하지 않는것도 일부러 받음. mapper에서 변환 ㄱㄱ 
struct BroadcastDTO: Codable {
    let id: String?
    let title: String?
    let caster: String?
    let viewers: Int?
    let liveStatus: Bool?
}
