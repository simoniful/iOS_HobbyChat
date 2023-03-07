//
//  Helper.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import Foundation
import UIKit

class Helper {
  static func convertGridCoordinate(lat: Double, long: Double) -> Int {
    let numberFomatter = NumberFormatter()
    numberFomatter.roundingMode = .floor
    numberFomatter.maximumSignificantDigits = 5
    
    let latitude = numberFomatter.string(for: lat + 90) ?? ""
    let longitude = numberFomatter.string(for: long + 180) ?? ""
    
    let region = Int("\(latitude)\(longitude)".components(separatedBy: ["."]).joined()) ?? 0
    return region
  }
  
  static func formatNumber(with mask: String, numberStr: String) -> String {
    let numbers = numberStr.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex
    for ch in mask where index < numbers.endIndex {
      if ch == "X" {
        result.append(numbers[index])
        index = numbers.index(after: index)
      } else {
        result.append(ch)
      }
    }
    return result
  }
  
  static func specifyPhoneNumber(_ numberStr: String) -> String {
    if numberStr != "" {
      let phoneNumber = numberStr.replacingOccurrences(of: "-", with: "")
      let startIdx = phoneNumber.index(phoneNumber.startIndex, offsetBy: 1)
      let result = String(phoneNumber[startIdx...])
      return "+\(82)\(result)"
    } else {
      return "error"
    }
  }
  
  static func transitionToNavRootView(view: UIView, controller: UIViewController) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      let nav = UINavigationController(rootViewController: controller)
      view.window?.rootViewController = nav
      UIView.transition(with: view, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
      view.window?.makeKeyAndVisible()
    }
  }
  
  static func transitionToRootView(view: UIView, controller: UIViewController) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      view.window?.rootViewController = controller
      UIView.transition(with: view, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
      view.window?.makeKeyAndVisible()
    }
  }
}
