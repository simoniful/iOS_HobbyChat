//
//  InAppRepository.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

final class InAppRepository: InAppRepositoryInterface {
  var manager: InAppManager
  
  init() {
    self.manager = InAppManager.shared
  }
}

extension InAppRepository {
  func requestPayment(
    index: Int,
    completion: @escaping (
      Result<String,
      InAppTargetError>) -> Void
  ) {
    self.manager.onPaymentTransactionHandler = { response in
      print(response)
      DispatchQueue.main.async {
        completion(response)
      }
    }
    self.manager.requestPayment(index: index)
  }
  
  func requestProductData(
    productIdentifiers: [String],
    completion: @escaping (
      Result<Void, InAppTargetError>
    ) -> Void
  ) {
    self.manager.onReceiveProductsHandler = { response in
      DispatchQueue.main.async {
        switch response {
        case .success(_):
          completion(.success(()))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    self.manager.requestProductData(productIdentifiers: Set(productIdentifiers))
  }
}
