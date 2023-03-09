//
//  PurchaseShopItemRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct PurchaseShopItemRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "receipt": receipt,
      "product": product
    ]
    return dict
  }
  
  let receipt: String
  let product: String
  
  init(itemInfo: PurchaseItemQuery) {
    receipt = itemInfo.receipt
    product = itemInfo.product
  }
}
