//
//  HomeReviewDetailCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit

final class HomeReviewDetailCell: BaseTableViewCell {
  static let identifier = "HomeReviewDetailCell"
  private let textView = UITextView()
  
  override func setupView() {
    super.setupView()
    contentView.addSubview(textView)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    textView.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16).priority(.low)
    }
  }
  
  override func setupAttributes() {
    super.setupAttributes()
    textView.isScrollEnabled = false
    textView.font = .body3R14
    textView.textColor = .black
    separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  func updateUI(review text: String) {
    textView.text = text
    textView.sizeToFit()
  }
}
