//
//  BroadcastView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import SwiftUI

struct BroadcastView: View {
    
    // view는 타입만알고 직접 인스턴스를 생성하지 않았따. 클린아키텍처로 가즈아아
    // viewModel = BroadcastViewModel()을 하지 않았따.
    // view가 재생성되어도 초기화 안되게 state상태값가지고 잇기.
    @StateObject private var viewModel: BroadcastViewModel
    
    init(viewModel: BroadcastViewModel) {
        // 초기화
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Hello, BroadCast!")
    }
}

#Preview {
    BroadcastView(viewModel: BroadcastViewModel())
}
