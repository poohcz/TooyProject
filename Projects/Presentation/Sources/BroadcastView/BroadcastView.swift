//
//  BroadcastView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import SwiftUI
import Domain

struct BroadcastView: View {
    @StateObject private var viewModel: BroadcastViewModel

    init(viewModel: BroadcastViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
            } else if !viewModel.errMsg.isEmpty {
                Text(viewModel.errMsg)
                    .foregroundColor(.red)
            } else {
                List(viewModel.broadcastList, id: \.casterId) { broadcast in
                    VStack(alignment: .leading) {
                        Text(broadcast.title)
                            .font(.headline)
                        Text(broadcast.casterId)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .task {  // 화면 나타날 때 자동 로드
            await viewModel.loadBroadcastList()
        }
    }
}

#Preview {
    let useCase = PreviewBroadcastUseCase()
    let viewModel = BroadcastViewModel(broadcastUseCase: useCase)

    BroadcastView(viewModel: viewModel)
}

final class PreviewBroadcastUseCase: BroadcastUseCase {
    func execute() async throws -> [BroadcastEntity] {
        [
            BroadcastEntity(title: "테스트 방송 1", casterId: "caster01"),
            BroadcastEntity(title: "테스트 방송 2", casterId: "caster02")
        ]
    }
}

