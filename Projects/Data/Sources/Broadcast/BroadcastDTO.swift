//
//  BroadcastDTO.swift
//  Data
//
//  Created by 김동율 on 1/7/26.
//

import Foundation



public struct BroadcastListDTO: Codable {
    public let broadcastList: [BroadcastDTO]
    
    public init(broadcastList: [BroadcastDTO]) {
        self.broadcastList = broadcastList
    }

}


// 일부러 옵셔널로 줌. 그리고 entity로 사용하지 않는것도 일부러 받음. mapper에서 변환 ㄱㄱ, 페이징안할거니간 토탈카운트 받지말것.
public struct BroadcastDTO: Codable {
    public let title: String?
    public let casterId: String?
    public let viewers: Int?
    public let liveStatus: Bool?
    
    public init(title: String?, casterId: String?, viewers: Int?, liveStatus: Bool?) {
        self.title = title
        self.casterId = casterId
        self.viewers = viewers
        self.liveStatus = liveStatus
    }
}







/*
 {
     "broadcastList": [
         {
             "casterId": "firstId",
             "title": "일번테스트",
             "liveStatus": false
         },
         {
             "casterId": "secondId",
             "title": "이번테스트",
             "liveStatus": true
         }
     ]
 }
 */


