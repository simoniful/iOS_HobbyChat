//
//  ChatRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct ChatRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "chat": chat,
    ]
    return dict
  }
  
  let chat: String
  
  init(chatQuery: ChatQuery) {
    chat = chatQuery.text
  }
}
