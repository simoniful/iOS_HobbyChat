//
//  ChatResponseDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct ChatResponseDTO: Codable {
  private enum CodingKeys: String, CodingKey {
    case array = "payload"
  }
  
  let array: [ChatDTO]
}

extension ChatResponseDTO {
  func toDomain() -> ChatList {
    return .init(
      array: array.map { $0.toDomain() }
    )
  }
}

struct ChatDTO: Codable {
  let _id: String
  let __v: Int
  let chat: String
  let createdAt: String
  let from: String
  let to: String
}

extension ChatDTO {
  func toDomain() -> Chat {
    return .init(
      _id: _id,
      __v: __v,
      text: chat,
      createdAt: createdAt.toDate,
      from: from,
      to: to
    )
  }
}
