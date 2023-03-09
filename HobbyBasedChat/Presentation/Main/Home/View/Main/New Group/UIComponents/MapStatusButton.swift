//
//  MapStatusButton.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit.UIButton

enum MapStatus {
  case search
  case matching
  case matched
  
  var image: UIImage {
    switch self {
    case .search:
      return Asset.search.image
    case .matching:
      return Asset.antenna.image
    case .matched:
      return Asset.message.image
    }
  }
}

final class MapStatusButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(status: MapStatus) {
    self.init()
    setupAttributes()
    setValidStatus(status: status)
  }
  
  required init?(coder: NSCoder) {
    fatalError("MapStatusButton: fatal Error Message")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    layer.cornerRadius = bounds.width / 2
  }
  
  private func setupAttributes() {
    layer.masksToBounds = true
    backgroundColor = .black
    tintColor = .white
    addShadow(radius: 2)
  }
  
  func setValidStatus(status: MapStatus) {
    setImage(status.image, for: .normal)
  }
}
