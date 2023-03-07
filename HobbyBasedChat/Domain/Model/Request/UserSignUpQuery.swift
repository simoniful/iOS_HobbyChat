//
//  UserSignUpQuery.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

struct UserSignUpQuery: Equatable {
  let phoneNumber: String
  let FCMtoken: String
  let nick: String
  let birth: Date
  let email: String
  let gender: GenderCase
}
