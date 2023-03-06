//
//  AppAppearance.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import UIKit
import Toast

final class AppAppearance {
  static func setupAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.backgroundColor = .systemBackground
    appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
    appearance.shadowImage = Asset.shadow.image
    appearance.shadowColor = nil
    
    let backImage = Asset.backNarrow.image
    appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().tintColor = .label
    UINavigationBar.appearance().barTintColor = .label
    
    var style = ToastStyle()
    style.messageFont = .body4R12
    style.messageColor = .white
    style.backgroundColor = .black
    style.titleAlignment = .center
    ToastManager.shared.style = style
  }
}
