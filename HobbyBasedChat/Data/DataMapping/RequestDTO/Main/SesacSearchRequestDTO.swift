//
//  SesacSearchRequestDTO.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation

struct SesacSearchRequestDTO: Codable {
  var toDictionary: DictionaryType {
    let dict: DictionaryType = [
      "type": 2,
      "region": region,
      "lat": lat,
      "long": long,
      "hf": hobbys
    ]
    return dict
  }
  
  var region: Int {
    let computedLat = Int((lat + 90.0) * 100)
    let computedLng = Int((long + 180.0) * 100)
    let computedTotal = "\(computedLat)\(computedLng)" as NSString
    return computedTotal.integerValue
  }
  let type: Int
  let long: Double
  let lat: Double
  let hobbys: [String]
  
  init(sesacSearch: SesacSearchQuery) {
    self.type = sesacSearch.type.value
    self.long = sesacSearch.coordinate.longitude
    self.lat = sesacSearch.coordinate.latitude
    self.hobbys = sesacSearch.hobbys
  }
}
