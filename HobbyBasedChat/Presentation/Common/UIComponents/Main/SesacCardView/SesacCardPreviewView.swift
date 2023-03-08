//
//  SesacPreviewView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit

final class SesacCardPreviewView: UIView {
  private let nickNameLabel = BaseLabel(font: .title1M16)
  let toggleButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func setupConstraints() {
    addSubview(toggleButton)
    addSubview(nickNameLabel)
    toggleButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.bottom.right.equalToSuperview().offset(-10)
      make.width.equalTo(toggleButton.snp.height)
    }
    nickNameLabel.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().offset(-16)
      make.right.equalTo(toggleButton.snp.left).offset(-16)
    }
  }
  
  private func setupAttributes() {
    nickNameLabel.text = UserDefaults.standard.string(forKey: UserDefaultKey.nickName)
    nickNameLabel.textAlignment = .left
    toggleButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    toggleButton.tintColor = .gray5
  }
  
  func addTarget(target: Any?, action: Selector, event: UIControl.Event) {
    toggleButton.addTarget(target, action: action, for: event)
  }
  
  func setNickname(nickname text: String){
    nickNameLabel.text = text
  }
  
  func setToggleButtonImage(isToggle: Bool) {
    if isToggle {
      toggleButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    } else {
      toggleButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
    }
  }
}
