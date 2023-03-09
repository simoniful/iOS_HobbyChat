//
//  DodgeRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct DodgeRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "otheruid": otheruid,
    ]
    return dict
  }
  
  let otheruid: String
  
  init(dodgeQuery: DodgeQuery) {
    otheruid = dodgeQuery.matchedUserID
  }
}
