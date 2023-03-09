//
//  ChatRelamRepository.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation
import RealmSwift

final class ChatRelamRepository: ChatRelamRepositoryInterface {
    var storage: RealmStorage

    init() {
        self.storage = RealmStorage.shared
    }
}

extension ChatRelamRepository {

    func loadChat(matchedID: String) -> [Chat] {
        let realmDTO = storage.read(matchedID: matchedID).toArray()
        return realmDTO.map { $0.toDomain() }
    }

    func createChat(chat: Chat, matchedID: String) {
        let chatDTO = ChatRealmDTO(chat: chat, matchedID: matchedID)
        storage.create(chat: chatDTO)
    }

    func saveChatList(chats: [Chat], matchedID: String) {
        let chatListDTO = chats.map { ChatRealmDTO(chat: $0, matchedID: matchedID) }
        storage.saveChats(chats: chatListDTO)
    }
}

extension Results {
    func toArray() -> [Element] {
      return compactMap { $0 }
    }
 }
