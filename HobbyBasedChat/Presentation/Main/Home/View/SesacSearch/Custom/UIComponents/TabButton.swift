//
//  TabButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit.UIButton

final class TabButton: UIButton {
  override var isSelected: Bool {
    didSet {
      isSelected ? setTitleColor(.green, for: .normal) : setTitleColor(.gray6, for: .normal)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttributes()
  }
  
  convenience init(title text: String, isSelected: Bool = false) {
    self.init()
    self.setTitle(text, for: .normal)
    self.isSelected = isSelected
  }
  
  required init?(coder: NSCoder) {
    fatalError("DefaultFillButton: fatal Error Message")
  }
  
  func setupAttributes() {
    titleLabel?.font = .title3M14
  }
}
