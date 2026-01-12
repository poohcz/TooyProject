//
//  BroadcastViewModel.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import Foundation
import Combine
import Domain

@MainActor
class BroadcastViewModel: ObservableObject {
    
    @Published var broadcastList: [BroadcastEntity] = []
    @Published var isLoading: Bool = false
    @Published var errMsg: String = ""
    
    // import domain했는데... 또또 실수 public....!!
    private let broadcastUseCase: BroadcastUseCase
    
    init(broadcastUseCase: BroadcastUseCase) {
        self.broadcastUseCase = broadcastUseCase
    }
    
    func loadBroadcastList() async {
        isLoading = true
        errMsg = ""
        
            do {
                let result = try await broadcastUseCase.execute()
                await MainActor.run {
                    self.broadcastList = result
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errMsg = "방송 목록을 불러오지 못했습니다."
                    self.isLoading = false
                }
            }
    }

}

// 일단 방송리스트만 나오면 될것 같고.. 뷰에서 보여줘야되는건 방제목+아이디정도만
// Rx말고 Combine연습 ㄱㄱ 똑같을거 같음 어차피 구독하고
// 데이터요청/처리(리스트가져오기), 상태관리(loading, error), view로 ui잘 넘기게 객체
// View와 UseCase 연결 지점이다. 여기는.

