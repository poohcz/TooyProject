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
        // StateObject 초기화 방식 주의
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("과외 플랫폼")
                .font(.largeTitle)
                .bold()
            
            VStack {
                Button {
                    print("화면이동합시다")
                    isCreatingRoom = true
                } label: {
                    Text("과외 방 만들기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                
                }
                
                Button {
                    print("화면이동합시다")
                } label: {
                    Text("과외 방 드가자아")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        // fullScreenCover 전체화면. isCreatingRoom의 상태값으로 방이동
        .fullScreenCover(isPresented: $isCreatingRoom) {
            CreateRoomView(viewModel: viewModel)
        }
    }
}

//#Preview {
//    WebRTCView()
//}
