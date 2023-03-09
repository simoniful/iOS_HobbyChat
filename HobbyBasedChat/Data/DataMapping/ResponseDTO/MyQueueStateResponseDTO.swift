//
//  MyQueueStateResponseDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct MyQueueStateResponseDTO: Codable {
  let dodged: Int
  let matched: Int
  let reviewed: Int
  let matchedNickname: String
  let matchedUserID: String
  
  private enum CodingKeys: String, CodingKey {
    case dodged
    case matched
    case reviewed
    case matchedNickname = "matchedNick"
    case matchedUserID = "matchedUid"
  }
}

extension MyQueueStateResponseDTO {
  func toDomain() -> MyQueueState {
    return .init(
      dodged: dodged,
      matched: matched,
      reviewed: reviewed,
      matchedNick: matchedNickname,
      matchedUid: matchedUserID
    )
  }
}
