//
//  BroadcaseEntity.swift
//  Domain
//
//  Created by 김동율 on 1/7/26.
//

import Foundation


// 실제 앱에서 사용하는 데이터. 3가지정도면 될듯. 실서버 만들어서 로컬에서 나중에~~~~
// 그리고 모듈을 import했다고 하더라도 public으로. 간만에 떠오르네... public을해야된다. 까먹었네. 다른모듈에서도 보임.
// 다른 객체들은 entity해놓지 말것 일단은.
public struct BroadcastEntity {

    public let title: String
    public let casterId: String

    public init(
        title: String,
        casterId: String
    ) {
        self.title = title
        self.casterId = casterId
    }
}
