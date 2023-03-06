//
//  AuthCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import UIKit
import Toast

final class AuthCoordinator: Coordinator {
  weak var delegate: CoordinatorDelegate?
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var type: CoordinatorStyleCase = .auth
  
  private let userDefaults = UserDefaults.standard
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {}
  
  func popRootViewController(toastMessage: String?) {
    navigationController.popToRootViewController(animated: true)
    navigationController.setNavigationBarHidden(true, animated: false)
    if let message = toastMessage {
      navigationController.view.makeToast(message, position: .top)
    }
  }
  
  func finish() {
    delegate?.didFinish(childCoordinator: self)
  }
}
