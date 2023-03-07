//
//  LoginUseCase.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginUseCase {
  private let userRepository: UserRepositoryInterface
  private let fireBaseRepository: FirebaseRepositoryInterface
  
  var verifyIDSuccessSignal = PublishSubject<String>()
  var verifyIDFailSignal = PublishSubject<FirbaseNetworkServiceError>()
  
  init(
    userRepository: UserRepositoryInterface,
    fireBaseRepository: FirebaseRepositoryInterface
  ) {
    self.userRepository = userRepository
    self.fireBaseRepository = fireBaseRepository
  }
  
  func verifyPhoneNumber(phoneNumber: String) {
    self.fireBaseRepository.verifyPhoneNumber(phoneNumber: phoneNumber) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let verifyID):
        self.savePhoneNumberInfo(phoneNumber: phoneNumber)
        self.verifyIDSuccessSignal.onNext(verifyID)
      case .failure(let error):
        self.verifyIDFailSignal.onNext(error)
      }
    }
  }
  
  private func savePhoneNumberInfo(phoneNumber: String) {
    self.userRepository.savePhoneNumberInfo(phoneNumber: phoneNumber)
  }
}
