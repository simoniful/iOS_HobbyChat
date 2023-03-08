//
//  MyPageUpdateHeaderView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class MyPageUpdateHeaderView: UITableViewHeaderFooterView {
  static let identifier = "MyPageUpdateHeaderView"
  
  private let profileView = SesacCardProfileView()
  private let cardView = MyPageCardView()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("MyPageMenuHeaderView: fatal error")
  }
  
  private func setupView() {
    addSubview(profileView)
    addSubview(cardView)
  }
  
  private func setupConstraints() {
    profileView.snp.makeConstraints { make in
      make.top.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.height.equalTo(profileView.snp.width).multipliedBy(194.0 / 343)
    }
    cardView.snp.makeConstraints { make in
      make.top.equalTo(profileView.snp.bottom)
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16).priority(.low)
    }
  }
  
  func updateConstraints(isToggle: Bool) {
    if isToggle {
      cardView.snp.removeConstraints()
      cardView.snp.makeConstraints { make in
        make.top.equalTo(profileView.snp.bottom)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(-16)
        make.height.equalTo(50)
      }
    } else {
      cardView.snp.removeConstraints()
      cardView.snp.makeConstraints { make in
        make.top.equalTo(profileView.snp.bottom)
        make.left.equalToSuperview().offset(16)
        make.right.equalToSuperview().offset(-16)
        make.bottom.equalToSuperview().offset(-16).priority(.low)
      }
    }
  }
  
  func toggleAddTarget(target: Any?, action: Selector, event: UIControl.Event) {
    cardView.toggleAddTarget(target: target, action: action, event: event)
  }
  
  func setHeaderView(info: UserInfo) {
    profileView.setSesacImage(image: info.sesac.image)
    profileView.setBackgroundImage(image: info.background.image)
    cardView.setNickname(nickname: info.nick)
    cardView.setSesacTitle(reputation: info.reputation)
    if info.reviewedBefore.count != 0 {
      cardView.setReviewText(text: info.comment[0])
    }
  }
  
  func setToggleButtonImage(isToggle: Bool) {
    cardView.setToggleButtonImage(isToggle: isToggle)
  }
}
