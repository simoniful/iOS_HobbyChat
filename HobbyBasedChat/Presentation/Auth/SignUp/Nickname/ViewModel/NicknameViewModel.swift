//
//  NicknameViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation
import RxCocoa
import RxSwift

final class NicknameViewModel: ViewModel {
  private weak var coordinator: AuthCoordinator?
  
  struct Input {
    let didTextChange: Signal<String>
    let didNextButtonTap: Signal<String>
  }
  
  struct Output {
    let isValidState: Driver<Bool>
    let showToastAction: Signal<String>
  }
  
  var disposeBag = DisposeBag()
  
  private let isValidState = BehaviorRelay<Bool>(value: false)
  private let showToastAction = PublishRelay<String>()
  
  init(coordinator: AuthCoordinator?) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    input.didTextChange
      .map(validationText)
      .emit(onNext: { [weak self] isValid in
        guard let self = self else { return }
        self.isValidState.accept(isValid)
      })
      .disposed(by: disposeBag)
    
    input.didNextButtonTap
      .emit(onNext: { [weak self] text in
        guard let self = self else { return }
        if self.validationText(text: text) {
          self.saveNickName(nickName: text)
          self.coordinator?.showBirthViewController()
        } else {
          self.showToastAction.accept(ToastCase.nickNameLimitLength.description)
        }
      })
      .disposed(by: disposeBag)
    
    return Output(
      isValidState: isValidState.asDriver(),
      showToastAction: showToastAction.asSignal()
    )
  }
}

extension NicknameViewModel {
  private func validationText(text: String) -> Bool {
    if text.count >= 1 && text.count <= 10 {
      return true
    }
    return false
  }
  
  private func saveNickName(nickName: String) {
    UserDefaults.standard.set(nickName, forKey: UserDefaultKey.nickName)
  }
}
