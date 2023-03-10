//
//  InAppRepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

protocol InAppRepositoryInterface: AnyObject {
  func requestPayment(
      index: Int,
      completion: @escaping (
          Result< String,
          InAppTargetError>
      ) -> Void
  )

  func requestProductData(
      productIdentifiers: [String],
      completion: @escaping (
          Result< Void,
          InAppTargetError>
      ) -> Void
  )
}
