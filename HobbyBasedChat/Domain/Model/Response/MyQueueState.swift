//
//  MyQueueState.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct MyQueueState: Equatable {
  let dodged: Int
  let matched: Int
  let reviewed: Int
  let matchedNick: String
  let matchedUid: String
}
