//
//  EmailViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

final class EmailViewModel: ViewModel {
  private weak var coordinator: AuthCoordinator?
  
  struct Input {
    let didTextChange: Signal<String>
    let didNextButtonTap: Signal<String>
  }
  
  struct Output {
    let isValid: Driver<Bool>
    let showToastAction: Signal<String>
  }
  
  var disposeBag = DisposeBag()
  
  private let isValid = BehaviorRelay<Bool>(value: false)
  private let showToastAction = PublishRelay<String>()
  
  init(coordinator: AuthCoordinator?) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    
    input.didTextChange
      .map { $0.isValidEmail() }
      .emit(onNext: { [weak self] isValidState in
        guard let self = self else { return }
        self.isValid.accept(isValidState)
      })
      .disposed(by: disposeBag)
    
    input.didNextButtonTap
      .emit(onNext: { [weak self] text in
        guard let self = self else { return }
        if self.isValid.value {
          self.saveEmailInfo(email: text)
          self.coordinator?.showGenderViewController()
        } else {
          self.showToastAction.accept(ToastCase.inValidEmail.description)
        }
      })
      .disposed(by: disposeBag)
    
    return Output(
      isValid: isValid.asDriver(),
      showToastAction: showToastAction.asSignal()
    )
  }
}

extension EmailViewModel {
  
  private func saveEmailInfo(email: String) {
    UserDefaults.standard.set(email, forKey: UserDefaultKey.email)
  }
}
