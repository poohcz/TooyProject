//
//  WebRTCView.swift
//  Presentation
//
//  Created by 김동율 on 1/7/26.
//

import SwiftUI

public struct WebRTCView: View {
    @StateObject private var viewModel: WebRTCViewModel
    @State private var isCreatingRoom = false
    
    public init(viewModel: WebRTCViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("과외 플랫폼")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
            
            VStack(spacing: 16) {
                Button { isCreatingRoom = true } label: {
                    Text("과외 방 만들기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button { print("입장 로직") } label: {
                    Text("과외 방 드가자아")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $isCreatingRoom) {
            CreateRoomView(viewModel: viewModel)
        }
    }
}
