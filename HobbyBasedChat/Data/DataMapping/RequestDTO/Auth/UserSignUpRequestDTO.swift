//
//  UserSignUpRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation

struct UserRegisterInfoRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "phoneNumber": phoneNumber,
      "FCMtoken": FCMtoken,
      "nick": nick,
      "birth": birth,
      "email": email,
      "gender": gender,
    ]
    return dict
  }
  
  let phoneNumber: String
  let FCMtoken: String
  let nick: String
  let birth: String
  let email: String
  let gender: Int
  
  init(userSignUpInfo: UserSignUpQuery) {
    self.phoneNumber = transformPhoneNumber(phoneNumber: userSignUpInfo.phoneNumber)
    self.FCMtoken = userSignUpInfo.FCMtoken
    self.nick = userSignUpInfo.nick
    self.birth = userSignUpInfo.birth.dateToString()
    self.email = userSignUpInfo.email
    self.gender = userSignUpInfo.gender.value
  }
}

func transformPhoneNumber(phoneNumber: String) -> String {
  let index = phoneNumber.index(after: phoneNumber.startIndex)
  let formatPhoneNumber = "+82" + String(phoneNumber[index..<phoneNumber.endIndex])
  return formatPhoneNumber
}
