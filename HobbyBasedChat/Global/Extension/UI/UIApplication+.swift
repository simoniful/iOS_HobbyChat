//
//  UIApplication+.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit

extension UIApplication {
  var keyWindow: UIWindow? {
    return UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .first(where: { $0 is UIWindowScene })
      .flatMap({ $0 as? UIWindowScene })?.windows
      .first(where: \.isKeyWindow)
  }
}
