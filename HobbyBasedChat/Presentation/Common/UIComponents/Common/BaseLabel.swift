//
//  BaseLabel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit.UILabel

final class BaseLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupAttributes()
  }
  
  convenience init(font: UIFont) {
    self.init()
    self.font = font
  }
  
  convenience init(font: UIFont, textColor: UIColor = .label) {
    self.init()
    self.font = font
    self.textColor = textColor
    self.textAlignment = .center
  }
  
  convenience init(title text: String, font: UIFont, textColor: UIColor = .label) {
    self.init()
    self.text = text
    self.font = font
    self.textColor = textColor
    self.textAlignment = .center
  }
  
  required init?(coder: NSCoder) {
    fatalError("DefaultFillButton: fatal Error Message")
  }
  
  private func setupAttributes() {
    numberOfLines = 0
  }
}
