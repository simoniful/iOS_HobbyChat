//
//  UserInfoResponseDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation

struct UserInfoResponseDTO: Codable {
  private enum CodingKeys: String, CodingKey {
    case userID = "uid"
    case phoneNumber, email
    case fcmToken = "FCMtoken"
    case nick, birth, gender, hobby, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
    case transactionID = "transactionId"
    case reviewedBefore, reportedNum, reportedUser, dodgepenalty
    case dodgeNum, ageMin, ageMax, searchable, createdAt
  }
  
  let userID, phoneNumber, email, fcmToken: String
  let nick, birth: String
  let gender: Int
  let hobby: String?
  let comment: [String]
  let reputation: [Int]
  let sesac: Int
  let sesacCollection: [Int]
  let background: Int
  let backgroundCollection: [Int]
  let purchaseToken, transactionID, reviewedBefore: [String]
  let reportedNum: Int
  let reportedUser: [String]
  let dodgepenalty: Int?
  let dodgeNum, ageMin, ageMax: Int
  let searchable: Int
  let createdAt: String
}

extension UserInfoResponseDTO {
  func toDomain() -> UserInfo {
    return .init(
      userID: userID,
      phoneNumber: phoneNumber,
      email: email,
      fcmToken: fcmToken,
      nick: nick,
      birth: birth,
      gender: GenderCase(value: gender),
      hobby: hobby,
      comment: comment,
      reputation: reputation,
      sesac: SesacImageCase(value: sesac),
      sesacCollection: SesacImageCase.allCases.map {
        sesacCollection.contains($0.rawValue) ? 1 : 0
      },
      background: SesacBackgroundCase(value: background),
      backgroundCollection: SesacBackgroundCase.allCases.map { backgroundCollection.contains($0.rawValue) ? 1 : 0 },
      purchaseToken: purchaseToken,
      transactionID: transactionID,
      reviewedBefore: reviewedBefore,
      reportedNum: reportedNum,
      reportedUser: reportedUser,
      dodgepenalty: dodgepenalty,
      dodgeNum: dodgeNum,
      ageMin: ageMin,
      ageMax: ageMax,
      searchable: (searchable == 1) ? true : false,
      createdAt: createdAt
    )
  }
}
