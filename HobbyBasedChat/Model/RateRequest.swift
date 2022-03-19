//
//  RateRequest.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/20.
//

import Foundation

struct RateRequest: Codable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}

