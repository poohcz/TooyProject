//
//  BroadcastUseCase.swift
//  Domain
//
//  Created by 김동율 on 1/7/26.
//

// 프로토콜 선언(정의)???만 하는 곳. 앱이 뭘할수 있는지만...(행동(기능!!!)이라고 생각하면될듯). 구현은 절대 없다. Impl에서 구현은
import Foundation

public protocol BroadcastUseCase {
    // 하... dto에서부터 할것 그랫나...
    // 아래 2개 책임이 애매하다. 즉 usecase1개다 protocol1개. 들어가고 불러오고 책임이 애매함. 중요!!
    // 그리고 네이밍은 execute()로...
//    func loadBroadcastList() -> [BroadcastEntity]
    // 일단 삭제
//    func joinBroadcast()
    
    func execute() async throws -> [BroadcastEntity]
}
