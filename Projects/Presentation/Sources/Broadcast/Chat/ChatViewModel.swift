//
//  ChatViewModel.swift
//  Presentation
//
//  Created by 김동율 on 4/1/26.
//



import Foundation
import Domain


@MainActor
public class ChatViewModel: ObservableObject {
    @Published private(set) var messages: [ChatEntity] = []
    @Published private(set) var viewerCount: Int = 0
    @Published var chatInput: String = ""

    func sendChat() {
        guard !chatInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        // 나중에 소켓 연결 시 추가
        chatInput = ""
    }
}
