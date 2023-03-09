//
//  FilterButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit.UIButton

final class FilterButton: UIButton {
  override var isSelected: Bool {
    didSet {
      isSelected ? setValidStatus(status: .fill) : setValidStatus(status: .inactive)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttributes()
    isSelected = false
  }
  
  convenience init(title text: String) {
    self.init()
    setTitle(text, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("DefaultFillButton: fatal Error Message")
  }
  
  private func setupAttributes() {
    layer.masksToBounds = true
    titleLabel?.font = .body3R14
  }
  
  func setValidStatus(status: ButtonStatus) {
    backgroundColor = status.backgroundColor
    setTitleColor(status.titleColor, for: .normal)
  }
}
