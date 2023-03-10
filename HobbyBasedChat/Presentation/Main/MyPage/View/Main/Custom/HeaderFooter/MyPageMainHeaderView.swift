//
//  MyPageMainHeaderView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit
import SnapKit

final class MyPageMainHeaderView: UITableViewHeaderFooterView {
  static let identifier = "MyPageMenuHeaderVIew"
  static let height: CGFloat = 96
  
  private let profileImageView = ProfileImageView()
  private let nickNameLabel = BaseLabel(font: .title1M16)
  private let arrowImageView = UIImageView(image: Asset.arrowRight.image)
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraints()
    setupAttributes()
  }
  
  required init?(coder: NSCoder) {
    fatalError("MyPageMenuHeaderView: fatal error")
  }
  
  private func setupView() {
    addSubview(profileImageView)
    addSubview(arrowImageView)
    addSubview(nickNameLabel)
  }
  
  private func setupConstraints() {
    profileImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().offset(-20)
      make.width.equalTo(profileImageView.snp.height)
    }
    arrowImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.right.equalToSuperview().offset(-16)
      make.height.equalTo(20)
      make.width.equalTo(10)
    }
    nickNameLabel.snp.makeConstraints { make in
      make.left.equalTo(profileImageView.snp.right).offset(16)
      make.bottom.equalToSuperview().offset(-16)
      make.right.equalTo(arrowImageView.snp.left).offset(-16)
      make.top.equalToSuperview().offset(16)
    }
  }
  
  private func setupAttributes() {
    nickNameLabel.text = UserDefaults.standard.string(forKey: UserDefaultKey.nickName)
  }
}
