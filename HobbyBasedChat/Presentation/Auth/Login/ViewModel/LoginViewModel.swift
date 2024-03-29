//
//  LoginViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModel {
  private weak var coordinator: AuthCoordinator?
  private let loginUseCase: LoginUseCase
  
  struct Input {
    let didLimitTextChange: Driver<String>
    let didTextFieldBegin: Signal<Void>
    let didTextFieldEnd: Signal<Void>
    let verifyPhoneNumber: Signal<String>
  }
  struct Output {
    let phoneNumberText: Signal<String>
    let isValidState: Driver<Bool>
    let phoneNumberRemoveHiponAction: Signal<Void>
    let phoneNumberAddHiponAction: Signal<Void>
    let showToastAction: Signal<String>
    let indicatorAction: Driver<Bool>
  }
  
  private let phoneNumberText = PublishRelay<String>()
  private let isValidState = BehaviorRelay<Bool>(value: false)
  private let phoneNumberRemoveHiponAction = PublishRelay<Void>()
  private let phoneNumberAddHiponAction = PublishRelay<Void>()
  private let showToastAction = PublishRelay<String>()
  private let indicatorAction = BehaviorRelay<Bool>(value: false)
  
  var disposeBag = DisposeBag()
  
  init(coordinator: AuthCoordinator?, loginUseCase: LoginUseCase) {
    self.coordinator = coordinator
    self.loginUseCase = loginUseCase
  }
  
  func transform(input: Input) -> Output {
    input.didLimitTextChange
      .drive(onNext: { [weak self] text in
        guard let self = self else { return }
        self.phoneNumberText.accept(text)
        self.isValidState.accept(text.isValidPhoneNumber())
      })
      .disposed(by: disposeBag)
    
    input.didTextFieldBegin
      .emit(onNext: { [weak self] text in
        guard let self = self else { return }
        self.phoneNumberRemoveHiponAction.accept(())
      })
      .disposed(by: disposeBag)
    
    input.didTextFieldEnd
      .emit { [weak self] text in
        guard let self = self else { return }
        self.phoneNumberAddHiponAction.accept(())
      }
      .disposed(by: disposeBag)
    
    input.verifyPhoneNumber
      .emit(onNext: { [weak self] text in
        self?.indicatorAction.accept(true)
        self?.verifyPhoneNumber(phoneNumber: text)
      })
      .disposed(by: disposeBag)
    
    self.loginUseCase.verifyIDFailSignal
      .subscribe(onNext: { [weak self] error in
        self?.indicatorAction.accept(false)
        self?.showToastAction.accept(error.description)
      })
      .disposed(by: disposeBag)
    
    self.loginUseCase.verifyIDSuccessSignal
      .subscribe(onNext: { [weak self] verifyID in
        self?.indicatorAction.accept(false)
        self?.coordinator?.showCertifacationViewController(verifyID: verifyID)
      })
      .disposed(by: disposeBag)
    
    return Output(
      phoneNumberText: phoneNumberText.asSignal(),
      isValidState: isValidState.asDriver(),
      phoneNumberRemoveHiponAction: phoneNumberRemoveHiponAction.asSignal(),
      phoneNumberAddHiponAction: phoneNumberAddHiponAction.asSignal(),
      showToastAction: showToastAction.asSignal(),
      indicatorAction: indicatorAction.asDriver()
    )
  }
}

extension LoginViewModel {
  private func verifyPhoneNumber(phoneNumber: String) {
    self.loginUseCase.verifyPhoneNumber(phoneNumber: phoneNumber)
  }
}
