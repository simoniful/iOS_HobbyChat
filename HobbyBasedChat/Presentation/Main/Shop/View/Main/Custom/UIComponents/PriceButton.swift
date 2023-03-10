//
//  PriceButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit.UIButton

final class PriceButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttributes()
  }
  
  required init?(coder: NSCoder) {
    fatalError("PriceButton: fatal Error Message")
  }
  
  private func setupAttributes() {
    layer.masksToBounds = true
    titleLabel?.font = .title5M12
    layer.cornerRadius = 8
    layer.masksToBounds = true
    setDefault()
  }
  
  func setDefault() {
    backgroundColor = .gray2
    setTitle("보유", for: .normal)
    setTitleColor(.gray7, for: .normal)
  }
  
  func setNotHaving(text: String) {
    backgroundColor = .green
    setTitle(text, for: .normal)
    setTitleColor(.white, for: .normal)
  }
}
