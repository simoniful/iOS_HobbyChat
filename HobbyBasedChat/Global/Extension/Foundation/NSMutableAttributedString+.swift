//
//  NSMutableAttributedString+.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit

extension NSMutableAttributedString {
  func greenHighlight(string: String) -> NSMutableAttributedString {
    let font: UIFont = UIFont(name: AppFont.medium.rawValue, size: 24)!
    let color: UIColor = .green
    let attributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: color
    ]
    self.append(NSAttributedString(string: string, attributes: attributes))
    return self
  }
  
  func regular(string: String) -> NSMutableAttributedString {
    let font: UIFont = UIFont(name: AppFont.regular.rawValue, size: 24)!
    let attributes: [NSAttributedString.Key: Any] = [.font: font]
    self.append(NSAttributedString(string: string, attributes: attributes))
    return self
  }
}
