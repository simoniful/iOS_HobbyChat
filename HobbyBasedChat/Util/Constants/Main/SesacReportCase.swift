//
//  SesacReportCase.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

enum SesacReportCase: Int, CaseIterable {
  case illegal, impureWord, noshow, sensation, personalAttack, etc
  
  var title: String {
    switch self {
    case .illegal:
      return "불법/사기"
    case .impureWord:
      return "불편한언행"
    case .noshow:
      return "노쇼"
    case .sensation:
      return "선정성"
    case .personalAttack:
      return "인신공격"
    case .etc:
      return "기타"
    }
  }
}
