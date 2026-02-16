//
//  BroadcastView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//


import SwiftUI

public struct BroadcastView: View {

    @StateObject private var viewModel: BroadcastViewModel

    public init(viewModel: BroadcastViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        HaishinKitPreviewView(stream: viewModel.getStream())
            .ignoresSafeArea()
            .onAppear {
                viewModel.startSession()
            }
            .onDisappear {
                viewModel.stopSession()
            }
    }
}

#Preview {
    BroadcastView(viewModel: BroadcastViewModel())
}
