//
//  SelectedHobbyCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit

class SelectedHobbyCell: UICollectionViewCell {
  static let identifier = "SelectedHobbyCell"
  
  private let borderView = UIView()
  private let hobbyLabel = BaseLabel(font: .title4R14, textColor: .green)
  private let cancelImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    contentView.addSubview(borderView)
    borderView.addSubview(cancelImageView)
    borderView.addSubview(hobbyLabel)
    borderView.snp.makeConstraints { make in
      make.top.bottom.left.equalToSuperview()
      make.right.equalToSuperview().priority(999)
    }
    cancelImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.right.equalToSuperview().offset(-16)
      make.width.height.equalTo(16)
    }
    hobbyLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(5)
      make.left.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().offset(-5).priority(999)
      make.right.equalTo(cancelImageView.snp.left).offset(-6)
    }
  }
  
  private func setupAttributes() {
    borderView.layer.borderWidth = 1
    borderView.layer.borderColor = UIColor.green.cgColor
    borderView.layer.cornerRadius = 8
    cancelImageView.image = Asset.xmark.image
  }
  
  func updateUI(item: Hobby) {
    hobbyLabel.text = item.content
  }
}
