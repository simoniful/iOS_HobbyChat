//
//  BaseTableViewCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ViewRepresentable {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupAttributes()
    setupView()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() { }
  func setupConstraints() { }

  func setupAttributes() {
    contentView.isUserInteractionEnabled = false
    selectionStyle = .none
    separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }
}
