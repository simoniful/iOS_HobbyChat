//
//  ShopBackgroundItemUseCase .swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation
import RxSwift
import RxRelay

final class ShopBackgroundItemUseCase {
  private let userRepository: UserRepositoryInterface
  private let fireBaseRepository: FirebaseRepositoryInterface
  private let sesacRepository: SesacRepositoryInterface
  private let inAppRepository: InAppRepositoryInterface
  
  let successRequestReceipt = PublishRelay<String>()
  let successRequestProduct = PublishRelay<Void>()
  let successPurchaseProduct = PublishRelay<Void>()
  let failInAppService = PublishRelay<InAppTargetError>()
  var unKnownErrorSignal = PublishRelay<Void>()
  
  init(
    userRepository: UserRepositoryInterface,
    fireBaseRepository: FirebaseRepositoryInterface,
    sesacRepository: SesacRepositoryInterface,
    inAppRepository: InAppRepositoryInterface
  ) {
    self.userRepository = userRepository
    self.fireBaseRepository = fireBaseRepository
    self.sesacRepository = sesacRepository
    self.inAppRepository = inAppRepository
  }
}

extension ShopBackgroundItemUseCase {
  func requestProductData(productIdentifiers: [String]) {
    self.inAppRepository.requestProductData(productIdentifiers: productIdentifiers) { [weak self] response in
      switch response {
      case .success():
        self?.successRequestProduct.accept(())
      case .failure(let error):
        self?.failInAppService.accept(error)
      }
    }
  }
  
  func requestPayment(index: Int) {
    self.inAppRepository.requestPayment(index: index) { [weak self] response in
      switch response {
      case .success(let receipt):
        self?.successRequestReceipt.accept(receipt)
      case .failure(let error):
        self?.failInAppService.accept(error)
      }
    }
  }
}

extension ShopBackgroundItemUseCase {
  func requestPurchaseItem(receipt: String, background: SesacBackgroundCase) {
    let itemQuery = PurchaseItemQuery(receipt: receipt, product: background.identifier)
    self.sesacRepository.requestPurchaseItem(itemQuery: itemQuery) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(_):
        self.successPurchaseProduct.accept(())
      case .failure(let error):
        switch error {
        case .inValidIDTokenError:
          self.requestIDToken {
            self.requestPurchaseItem(receipt: receipt, background: background)
          }
        default:
          self.unKnownErrorSignal.accept(())
        }
      }
    }
  }
}

extension ShopBackgroundItemUseCase {
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

extension ShopBackgroundItemUseCase {
  private func saveIdTokenInfo(idToken: String) {
    self.userRepository.saveIdTokenInfo(idToken: idToken)
  }
  
  private func logoutUserInfo() {
    self.userRepository.logoutUserInfo()
  }
}
