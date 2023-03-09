//
//  SesacCardReportView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SesacCardReportView: UIView {
  let buttons: [SelectionButton] = {
    var buttons = [SelectionButton]()
    SesacReportCase.allCases.forEach { value in
      let button = SelectionButton(title: value.title)
      button.titleLabel?.font = .title4R14
      buttons.append(button)
    }
    return buttons
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    for i in 0..<2 {
      let index = i * 3
      let horizantalStackView = UIStackView(
        arrangedSubviews: [buttons[index], buttons[index + 1], buttons[index + 2]]
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
    setConstraints()
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
  
  private func setConstraints() {
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    buttons.forEach {
      $0.bind()
      $0.titleLabel?.minimumScaleFactor = 0.5
    }
  }
}
