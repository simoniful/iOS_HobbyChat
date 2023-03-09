//
//  ReportRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct ReportRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "otheruid": otheruid,
      "reportedReputation": reportedReputation,
      "comment": comment
    ]
    return dict
  }
  
  let otheruid: String
  let reportedReputation: [Int]
  let comment: String
  
  init(report: ReportQuery) {
    otheruid = report.matchedUserID
    reportedReputation = report.report
    comment = report.text
  }
}
