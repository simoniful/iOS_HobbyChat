//
//  SesacFriendRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct SesacFriendRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "otheruid": otheruid,
    ]
    return dict
  }
  
  let otheruid: String
  
  init(sesacFriendQuery: SesacFriendQuery) {
    otheruid = sesacFriendQuery.userID
  }
}
