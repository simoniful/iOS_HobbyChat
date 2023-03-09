//
//  UpdateShopRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation

struct UpdateShopRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "sesac": sesac,
      "background": background
    ]
    return dict
  }
  
  let sesac: Int
  let background: Int
  
  init(updateShop: UpdateShopQuery) {
    sesac = updateShop.sesac.rawValue
    background = updateShop.background.rawValue
  }
}
