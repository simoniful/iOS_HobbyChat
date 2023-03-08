//
//  MyPageUpdateUseCase.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation
import RxSwift
import RxRelay

final class MyPageUpdateUseCase {
  private let userRepository: UserRepositoryInterface
  private let fireBaseRepository: FirebaseRepositoryInterface
  private let sesacRepository: SesacRepositoryInterface
  
  var successUserInfoSignal = PublishRelay<UserInfo>()
  var successWithdrawSignal = PublishRelay<Void>()
  var successUpdateSignal = PublishRelay<Void>()
  var unKnownErrorSignal = PublishRelay<Void>()
  
  init(
    userRepository: UserRepositoryInterface,
    fireBaseRepository: FirebaseRepositoryInterface,
    sesacRepository: SesacRepositoryInterface
  ) {
    self.userRepository = userRepository
    self.fireBaseRepository = fireBaseRepository
    self.sesacRepository = sesacRepository
  }
  
  func requestUserInfo() {
    self.sesacRepository.requestUserInfo { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        self.successUserInfoSignal.accept(result)
      case .failure(let error):
        switch error {
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestUserInfo()
          }
        default:
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
  
  func requestWithdraw() {
    sesacRepository.requestWithdraw() { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let code):
        print("성공 -->", code)
        self.withdrawUserInfo()
        self.successWithdrawSignal.accept(())
      case .failure(let error):
        print(error.description)
        switch error {
        case .unregisterUser:
          self.withdrawUserInfo()
          self.unKnownErrorSignal.accept(())
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestWithdraw()
          }
        default:
          self.logoutUserInfo()
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
  
  func requestUpdateUserInfo(updateUserInfo: UpdateUserInfo) {
    let info = UserUpdateQuery(searchable: updateUserInfo.0, ageMin: updateUserInfo.1, ageMax: updateUserInfo.2, gender: updateUserInfo.3, hobby: updateUserInfo.4!)
    sesacRepository.requestUpdateUserInfo(userUpdateInfo: info) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(_):
        self.saveGenderInfo(gender: updateUserInfo.3)
        self.successUpdateSignal.accept(())
      case .failure(let error):
        print(error.description)
        switch error {
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestUpdateUserInfo(updateUserInfo: updateUserInfo)
          }
        default:
          self.logoutUserInfo()
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
  
  private func requestIDToken(completion: @escaping () -> Void) {
    fireBaseRepository.requestIdtoken { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let idToken):
        print("재발급 성공--> \(idToken)")
        self.saveIdTokenInfo(idToken: idToken)
        completion()
      case .failure(let error):
        print(error.description)
        self.logoutUserInfo()
        self.unKnownErrorSignal.accept(())
      }
    }
  }
  
  private func saveGenderInfo(gender: GenderCase) {
    self.userRepository.saveGenderInfo(gender: gender)
  }
  
  private func saveIdTokenInfo(idToken: String) {
    self.userRepository.saveIdTokenInfo(idToken: idToken)
  }
  
  private func withdrawUserInfo() {
    self.userRepository.withdrawUserInfo()
  }
  
  private func logoutUserInfo() {
    self.userRepository.logoutUserInfo()
  }
}
