//
//  ReportRequest.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/20.
//

import Foundation

struct ReportRequest: Codable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}
