//
//  Data+Extension.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation

extension Date {
  var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
  
  func customDateToString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
    let str = dateFormatter.string(from: self)
    return str
  }
}
