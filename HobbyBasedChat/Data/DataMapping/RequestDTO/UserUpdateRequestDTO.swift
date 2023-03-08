//
//  UserUpdateRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation

struct UserUpdateRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "searchable": searchable,
      "ageMin": ageMin,
      "ageMax": ageMax,
      "gender": gender,
      "hobby": hobby,
    ]
    return dict
  }
  
  let searchable: Int
  let ageMin: Int
  let ageMax: Int
  let gender: Int
  let hobby: String
  
  init(userUpdateInfo: UserUpdateQuery) {
    self.searchable = userUpdateInfo.searchable ? 1 : 0
    self.ageMin = userUpdateInfo.ageMin
    self.ageMax = userUpdateInfo.ageMax
    self.gender = userUpdateInfo.gender.value
    self.hobby = userUpdateInfo.hobby
  }
}
