//
//  NearHobbyCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import SnapKit

final class HobbyCell: UICollectionViewCell {
  static let identifier = "HobbyCell"
  private var hobbyLabel = HobbyLabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraint()
    hobbyLabel.isFixed = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraint() {
    contentView.addSubview(hobbyLabel)
    hobbyLabel.snp.makeConstraints { make in
      make.top.bottom.left.equalToSuperview()
      make.right.equalToSuperview().priority(999)
    }
  }
  
  func updateUI(item: Hobby) {
    hobbyLabel.text = item.content
    hobbyLabel.isFixed = item.isRecommended
  }
  
  func updateUI(hobby text: String) {
    hobbyLabel.text = text
  }
}
