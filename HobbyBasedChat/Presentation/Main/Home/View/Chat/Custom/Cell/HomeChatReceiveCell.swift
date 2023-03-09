//
//  ChatReceiveCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit

final class HomeChatReceiveCell: BaseTableViewCell {
  static let identifier = "HomeChatReceiveCell"
  
  private let textView = UITextView()
  private let dateLabel = BaseLabel(font: .title5R12, textColor: .gray6)
  
  override func setupView() {
    super.setupView()
    contentView.addSubview(textView)
    contentView.addSubview(dateLabel)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    textView.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(16)
      make.width.lessThanOrEqualToSuperview().multipliedBy(0.604)
      make.bottom.equalToSuperview().offset(-16).priority(.low)
    }
    dateLabel.snp.makeConstraints { make in
      make.left.equalTo(textView.snp.right).offset(8)
      make.bottom.equalTo(textView.snp.bottom)
    }
  }
  
  override func setupAttributes() {
    super.setupAttributes()
    textView.layer.cornerRadius = 8
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.gray5.cgColor
    textView.font = .body3R14
    textView.textColor = .black
    textView.isScrollEnabled = false
    textView.isEditable = false
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    dateLabel.textAlignment = .left
  }
  
  func updateUI(chat: Chat) {
    textView.text = chat.text
    dateLabel.text = chat.createdAt.toString
    textView.sizeToFit()
  }
}
