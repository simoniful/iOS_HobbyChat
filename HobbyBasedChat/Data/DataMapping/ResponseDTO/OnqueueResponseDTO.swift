//
//  OnqueueResponseDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct OnqueueResponseDTO: Codable {
  let fromQueueDB, fromQueueDBRequested: [QueueDB]
  let fromRecommend: [String]
}

struct QueueDB: Codable {
  private enum CodingKeys: String, CodingKey {
    case userID = "uid"
    case nick
    case latitude = "lat"
    case longitude = "long"
    case reputation, reviews
    case hobbys = "hf"
    case gender, type, sesac, background
  }
  
  let userID, nick: String
  let latitude, longitude: Double
  let reputation: [Int]
  let hobbys, reviews: [String]
  let gender, type, sesac, background: Int
}

extension OnqueueResponseDTO {
  func toDomain() -> Onqueue {
    return .init(
      fromSesacDB: fromQueueDB.map { $0.toDomain() },
      fromSesacDBRequested: fromQueueDBRequested.map { $0.toDomain() },
      fromRecommend: fromRecommend
    )
  }
}

extension QueueDB {
  func toDomain() -> SesacDB {
    return .init(
      userID: userID,
      nick: nick,
      coordinate: Coordinate(latitude: latitude, longitude: longitude),
      reputation: reputation,
      hobbys: hobbys,
      reviews: reviews,
      gender: GenderCase(value: gender),
      type: GenderCase(value: type),
      sesac: SesacImageCase(value: sesac),
      background: SesacBackgroundCase(value: background)
    )
  }
}
