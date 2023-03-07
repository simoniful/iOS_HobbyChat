//
//  BaseButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit.UIButton

class BaseButton: UIButton {
  var isValid: Bool = false {
    didSet {
      isValid ? setupValidStatus(status: .fill) : setupValidStatus(status: .disable)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttributes()
  }
  
  convenience init(title text: String) {
    self.init()
    setTitle(text, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("DefaultFillButton: fatal Error Message")
  }
  
  func setupAttributes() {
    layer.masksToBounds = true
    layer.cornerRadius = 8
    titleLabel?.font = .body3R14
  }
  
  func setupValidStatus(status: ButtonStatus) {
    layer.borderWidth = 1
    layer.borderColor = status.borderColor
    backgroundColor = status.backgroundColor
    setTitleColor(status.titleColor, for: .normal)
  }
}
