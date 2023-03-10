//
//  InAppTargetError.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

enum InAppTargetError: Error {
  case noProductIDsFound
  case noProductsFound
  case paymentWasCancelled
  case productRequestFailed
  case impossiblePaymant
  case onReceiptEncodingFailed
}
