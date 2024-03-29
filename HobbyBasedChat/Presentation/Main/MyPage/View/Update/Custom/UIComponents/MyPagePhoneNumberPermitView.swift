//
//  MyPageCardPhoneNumberPermitView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit

final class MyPagePhoneNumberPermitView: UIView {
  private let titleLabel = BaseLabel(title: "내 번호 검색 허용", font: .title4R14)
  private let toggleSwitch = UISwitch()
  
  var toggleSwitchIsOn: Bool {
    return toggleSwitch.isOn
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  func setSwitch(isOn: Bool) {
    toggleSwitch.isOn = isOn
  }
  
  private func setupConstraints() {
    addSubview(toggleSwitch)
    addSubview(titleLabel)
    toggleSwitch.snp.makeConstraints { make in
      make.right.equalToSuperview()
      make.centerY.equalToSuperview()
      make.width.equalTo(50)
    }
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalTo(toggleSwitch.snp.left).offset(-16)
    }
  }
  
  private func setupAttributes() {
    titleLabel.textAlignment = .left
    toggleSwitch.onTintColor = .green
  }
}
