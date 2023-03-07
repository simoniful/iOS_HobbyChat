//
//  SelectionButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectionButton: BaseButton {
  override var isSelected: Bool {
    didSet {
      isSelected ? setupValidStatus(status: .fill) : setupValidStatus(status: .inactive)
    }
  }
  
  let selectedRelay = BehaviorRelay(value: false)
  private let disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isSelected = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind() {
    let driver = rx.tap
      .map { [weak self] in
        guard let self = self else { return false }
        return !self.isSelected
      }
      .asDriver(onErrorJustReturn: false)
    
    driver
      .drive(rx.isSelected)
      .disposed(by: disposeBag)
    
    driver
      .drive(selectedRelay)
      .disposed(by: disposeBag)
  }
}
