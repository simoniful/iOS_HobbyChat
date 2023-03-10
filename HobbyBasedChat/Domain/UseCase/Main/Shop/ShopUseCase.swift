//
//  ShopUseCase.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation
import RxSwift
import RxRelay

final class ShopUseCase {
  private let userRepository: UserRepositoryInterface
  private let fireBaseRepository: FirebaseRepositoryInterface
  private let sesacRepository: SesacRepositoryInterface
  
  var successSesacShopInfo = PublishRelay<UserInfo>()
  var successUpdateShop = PublishRelay<Void>()
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
}

extension ShopUseCase {
  func requestSesacShopInfo() {
    self.sesacRepository.requestShopUserInfo { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let info):
        self.successSesacShopInfo.accept(info)
      case .failure(let error):
        switch error {
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestSesacShopInfo()
          }
        default:
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
  
  func requestUpdateShop(sesac: SesacImageCase, background: SesacBackgroundCase) {
    let query = UpdateShopQuery(sesac: sesac, background: background)
    self.sesacRepository.requestUpdateShop(updateShop: query) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let info):
        print(info)
        self.successUpdateShop.accept(())
      case .failure(let error):
        switch error {
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestUpdateShop(sesac: sesac, background: background)
          }
        default:
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
}

extension ShopUseCase {
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
}

extension ShopUseCase {
  private func saveIdTokenInfo(idToken: String) {
    self.userRepository.saveIdTokenInfo(idToken: idToken)
  }
  
  private func logoutUserInfo() {
    self.userRepository.logoutUserInfo()
  }
}

