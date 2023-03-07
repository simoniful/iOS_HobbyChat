//
//  String+.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

extension String {
  var toDate: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
    let date = dateFormatter.date(from: self)!
    return date
  }
  
  func limitString(limitCount: Int) -> String {
    if self.count > limitCount {
      let index = self.index(self.startIndex, offsetBy: limitCount)
      return String( self[..<index] )
    }
    return self
  }
  
  func removeHipon() -> String {
    return self.components(separatedBy: ["-"]).joined()
  }
  
  func addHipon() -> String {
    let target = self.removeHipon()
    if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
      let modString = regex.stringByReplacingMatches(in: target, options: [], range: NSRange(target.startIndex..., in: target), withTemplate: "$1-$2-$3")
      return modString
    }
    return self
  }
  
  func isValidPhoneNumber() -> Bool {
    let regex = "^01[0-1, 7][0-9]{7,8}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: self)
    return isValid ? true : false
  }
  
  func isValidCertificationNumber() -> Bool {
    let regex = "[0-9]{0,}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: self)
    return isValid ? true : false
  }
  
  func isValidEmail() -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: self)
    return isValid
  }
}
