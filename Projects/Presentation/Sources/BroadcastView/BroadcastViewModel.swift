//
//  BroadcastViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import Foundation
import Combine

class BroadcastViewModel: ObservableObject {
    
    @Published var broadcastList: [BroadcastList] = []
    @Published var isLoading: Bool = false
    @Published var errMsg: String = ""
    
    private let broadcastUseCase: BroadcastUseCaseType
    
    
    
    
    
    func getBroadcastList() {
        
    }

}

// 일단 방송리스트만 나오면 될것 같고.. 뷰에서 보여줘야되는건 방제목+아이디정도만
// Rx말고 Combine연습 ㄱㄱ 똑같을거 같음 어차피 구독하고
// 데이터요청/처리(리스트가져오기), 상태관리(loading, error), view로 ui잘 넘기게 객체
// View와 UseCase 연결 지점이다. 여기는.





//더미 데이터
struct BroadcastList {
    let id: Int
    let title: String
}

