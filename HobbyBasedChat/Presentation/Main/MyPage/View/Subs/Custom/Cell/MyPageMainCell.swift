//
//  MyPageMainCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class MyPageMainCell: BaseTableViewCell {
  static let identifier = "MyPageMainCell"
  static let height: CGFloat = 74
  
  private let contentImageView = UIImageView()
  private let contentLabel = BaseLabel(font: .title2R16)
  
  override func setupView() {
    super.setupView()
    contentView.addSubview(contentImageView)
    contentView.addSubview(contentLabel)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    contentImageView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.width.height.equalTo(20)
      make.centerY.equalToSuperview()
    }
    contentLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-16)
      make.left.equalTo(contentImageView.snp.right).offset(16)
      make.right.equalToSuperview().offset(-16)
      make.top.equalToSuperview().offset(16)
    }
  }
  
  override func setupAttributes() {
    super.setupAttributes()
  }
  
  func setData(menu: MyPageMainCase) {
    contentImageView.image = UIImage(named: menu.imageName)
    contentLabel.text = menu.title
  }
}
