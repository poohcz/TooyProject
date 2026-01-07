//
//  BroadcastUseCase.swift
//  Domain
//
//  Created by 김동율 on 1/7/26.
//

// 프로토콜 선언(정의)???만 하는 곳. 앱이 뭘할수 있는지만...(행동(기능!!!)이라고 생각하면될듯). 구현은 절대 없다. Impl에서 구현은
import Foundation

protocol BroadcastUseCase {
    // 하... dto에서부터 할것 그랫나...
    func getBroadcastList() -> [BroadcastEntity]
    func joinBroadcast()
}
