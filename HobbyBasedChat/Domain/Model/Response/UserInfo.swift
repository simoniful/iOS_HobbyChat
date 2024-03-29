//
//  UserInfo.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

struct UserInfo: Equatable {
  let userID, phoneNumber, email, fcmToken, nick, birth: String
  let gender: GenderCase
  let hobby: String?
  let comment: [String]
  let reputation: [Int]
  let sesac: SesacImageCase
  let sesacCollection: [Int]
  let background: SesacBackgroundCase
  let backgroundCollection: [Int]
  let purchaseToken, transactionID, reviewedBefore: [String]
  let reportedNum: Int
  let reportedUser: [String]
  let dodgepenalty: Int?
  let dodgeNum, ageMin, ageMax: Int
  let searchable: Bool
  let createdAt: String
}
