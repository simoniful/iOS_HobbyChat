//
//  ReviewRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct ReviewRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "otheruid": otheruid,
      "reputation": reputation,
      "comment": comment
    ]
    return dict
  }
  
  let otheruid: String
  let reputation: [Int]
  let comment: String
  
  init(review: ReviewQuery) {
    otheruid = review.matchedUserID
    reputation = review.reputation
    comment = review.text
  }
}
