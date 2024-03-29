//
//  SesacTitleView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

enum SesacTitleCase: Int, CaseIterable {
  case goodManner, punctual, quickResponse, kind, handy, beneficial
  
  var title: String {
    switch self {
    case .goodManner:
      return "좋은 매너"
    case .punctual:
      return "정확한 시간 약속"
    case .quickResponse:
      return "빠른 응답"
    case .kind:
      return "친절한 성격"
    case .handy:
      return "능숙한 취미 성격"
    case .beneficial:
      return "유익한 시간"
    }
  }
}

final class SesacCardTitleView: UIView {
  let buttons: [SelectionButton] = {
    var buttons = [SelectionButton]()
    SesacTitleCase.allCases.forEach { value in
      let button = SelectionButton(title: value.title)
      buttons.append(button)
    }
    return buttons
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    for i in 0..<3 {
      let index = i * 2
      let horizantalStackView = UIStackView(
        arrangedSubviews: [buttons[index], buttons[index + 1]]
      )
      horizantalStackView.axis = .horizontal
      horizantalStackView.distribution = .fillEqually
      horizantalStackView.spacing = 8
      stackView.addArrangedSubview(horizantalStackView)
    }
    return stackView
  }()
  
  let validRelay = BehaviorRelay(value: false)
  private let disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    bind()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacTitleView: fatal error")
  }
  
  private func bind() {
    Observable.merge(
      buttons[0].selectedRelay.asObservable(),
      buttons[1].selectedRelay.asObservable(),
      buttons[2].selectedRelay.asObservable(),
      buttons[3].selectedRelay.asObservable(),
      buttons[4].selectedRelay.asObservable(),
      buttons[5].selectedRelay.asObservable()
    )
    .map { [weak self] _ in
      guard let self = self else { return false }
      for button in self.buttons {
        if button.isSelected {
          return true
        }
      }
      return false
    }
    .asDriver(onErrorJustReturn: false)
    .drive(validRelay)
    .disposed(by: disposeBag)
  }
  
  func setSesacTitle(reputation: [Int]) {
    for index in 0..<SesacTitleCase.allCases.count {
      buttons[index].isSelected = (reputation[index] > 0)
    }
  }
  
  private func setupConstraints() {
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16)
      make.top.equalToSuperview().offset(8)
    }
  }
}
