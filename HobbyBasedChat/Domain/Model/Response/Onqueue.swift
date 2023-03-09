//
//  Onqueue.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct Onqueue {
  let fromSesacDB, fromSesacDBRequested: [SesacDB]
  let fromRecommend: [String]
}

struct SesacDB {
  let userID, nick: String
  let coordinate: Coordinate
  let reputation: [Int]
  let hobbys, reviews: [String]
  let gender: GenderCase
  let type: GenderCase
  let sesac: SesacImageCase
  let background: SesacBackgroundCase
}
