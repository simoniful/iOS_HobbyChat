//
//  MyPageCardHobbyView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit

final class MyPageHobbyView: UIView {
  private let titleLabel = BaseLabel(title: "자주 하는 취미", font: .title4R14)
  private let textField = BaseTextField(placeHolder: "취미를 입력해주세요")
  
  var getHobby: String? {
    return textField.text
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func setupConstraints() {
    addSubview(textField)
    addSubview(titleLabel)
    textField.snp.makeConstraints { make in
      make.right.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(160)
    }
    titleLabel.snp.makeConstraints { make in
      make.left.top.bottom.equalToSuperview()
      make.right.equalTo(textField.snp.left).offset(-16)
    }
  }
  
  func setText(text: String) {
    textField.text = text
  }
  
  private func setupAttributes() {
    titleLabel.textAlignment = .left
  }
}
