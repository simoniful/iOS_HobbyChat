//
//  HobbySettingSectionHeaderView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit

final class HobbySettingSectionHeaderView: UICollectionReusableView {
  static let identifier = "HobbySettingSectionHeaderView"
  private let titleLabel = BaseLabel(font: .title5R12, textColor: .black)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func setupConstraints() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.right.bottom.left.equalToSuperview()
      make.height.equalTo(40)
    }
    titleLabel.textAlignment = .left
  }
  
  func setTitle(text: String) {
    self.titleLabel.text = text
  }
}
