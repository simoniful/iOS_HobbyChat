//
//  Chat.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct ChatList {
  let array: [Chat]
}

struct Chat: Equatable {
  let _id: String
  let __v: Int
  let text: String
  let createdAt: Date
  let from: String
  let to: String
}
