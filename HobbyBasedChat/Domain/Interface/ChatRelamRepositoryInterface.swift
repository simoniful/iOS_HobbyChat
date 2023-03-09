//
//  ChatRelamRepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation
import RealmSwift

protocol ChatRelamRepositoryInterface: AnyObject {
  func loadChat(matchedID: String) -> [Chat]
  
  func createChat(chat: Chat, matchedID: String)
  
  func saveChatList(chats: [Chat], matchedID: String)
}

