//
//  UserUpdateQuery.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation

struct UserUpdateQuery: Equatable {
  let searchable: Bool
  let ageMin: Int
  let ageMax: Int
  let gender: GenderCase
  let hobby: String
}
