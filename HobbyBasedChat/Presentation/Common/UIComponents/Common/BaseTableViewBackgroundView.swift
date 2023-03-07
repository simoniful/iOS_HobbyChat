//
//  TableViewBackgroundView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit

final class BaseTableViewBackgroundView: UIView {
  let emptyImageView = UIImageView(image: Asset.empty.image)
  let titleLabel = BaseLabel(font: .display1R20, textColor: .black)
  let messageLabel = BaseLabel(font: .title4R14, textColor: .gray7)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(frame: CGRect, title: String, message: String) {
    self.init(frame: frame)
    titleLabel.text = title
    messageLabel.text = message
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupView()
    setupConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func setupView() {
    [titleLabel, emptyImageView, messageLabel].forEach {
      self.addSubview($0)
    }
  }
  
  private func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
    }
    emptyImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.width.equalTo(64)
      make.height.equalTo(56)
      make.bottom.equalTo(titleLabel.snp.top).offset(-36)
    }
    messageLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
}
