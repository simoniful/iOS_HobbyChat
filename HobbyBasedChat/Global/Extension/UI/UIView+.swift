//
//  UIView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit.UIView

extension UIView {
  func addShadow(radius: CGFloat) {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = radius
    self.layer.shadowOffset = .zero
  }
}
