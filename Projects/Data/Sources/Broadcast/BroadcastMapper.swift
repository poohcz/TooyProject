//
//  BroadcastMapper.swift
//  Data
//
//  Created by 김동율 on 1/7/26.
//

import Foundation
import Domain

public protocol BroadcastMapperProtocol {
    // 단일테스트용. unittest해보자. 나중에 코드 완성되면
    func map(dto: BroadcastDTO) -> BroadcastEntity?
    // 배열로 실제 api기능. 리스트 보여줄때.
    func map(dtoList: [BroadcastDTO]) -> [BroadcastEntity]
}

public final class BroadcastMapper: BroadcastMapperProtocol {
    
    public init() {}

    public func map(dto: BroadcastDTO) -> BroadcastEntity? {
        
        guard
            let title = dto.title,
            let casterId = dto.casterId
        else {
            logInvalidDTO(dto)
            return nil
        }

        return BroadcastEntity(
            title: title,
            casterId: casterId
        )
    }

    public func map(dtoList: [BroadcastDTO]) -> [BroadcastEntity] {
        // 컴팩트맵으로 변환한거는 nil로 있는 객체는 제외해버리는 단점.
        // 그래서 서버에서 빈값인지, 클라이언트에서 실수한건지 알수 없음.
        // 단점 보완하기 위해서 함수 하나 추가
        dtoList.compactMap { map(dto: $0) }
    }
    
    private func logInvalidDTO(_ dto: BroadcastDTO) {
        #if DEBUG
        print("dto체크용", dto)
        #endif
    }
    
}
