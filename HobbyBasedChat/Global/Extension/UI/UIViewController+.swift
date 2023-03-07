//
//  UIViewController + Extension.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/11.
//

import UIKit
import Toast

extension UIViewController {
  var topViewController: UIViewController? {
    return self.topViewController(currentViewController: self)
  }
  
  func topViewController (currentViewController: UIViewController) -> UIViewController {
    if let tabBarController = currentViewController as? UITabBarController,
       let selectedViewController = tabBarController.selectedViewController {
      return self.topViewController(currentViewController: selectedViewController)
      
    } else if let navigationController = currentViewController as? UINavigationController,
              let visibleViewController = navigationController.visibleViewController {
      return self.topViewController(currentViewController: visibleViewController)
    } else if let presentedViewController = currentViewController.presentedViewController {
      return self.topViewController(currentViewController: presentedViewController)
    } else {
      return currentViewController
    }
  }
  
  func makeToastStyle() {
    var style = ToastStyle()
    style.messageFont = .body4R12
    style.messageColor = .white
    style.backgroundColor = .black
    style.titleAlignment = .center
    ToastManager.shared.style = style
  }
}
