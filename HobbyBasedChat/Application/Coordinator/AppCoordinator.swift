//
//  AppCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import UIKit

final class AppCoordinator: Coordinator {
  weak var delegate: CoordinatorDelegate?
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var type: CoordinatorStyleCase = .app
  
  private let userDefaults = UserDefaults.standard
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    navigationController.setNavigationBarHidden(true, animated: false)
    userDefaults.set(false, forKey: UserDefaultKey.isNotFirstUser)
    userDefaults.set(false, forKey: UserDefaultKey.isLoggedIn)
  }
  
  func start() {
//    if userDefaults.bool(forKey: UserDefaultKey.isLoggedIn) {
//      connectMainFlow()
//    } else {
//      connectAuthFlow()
//    }
    connectAuthFlow()
  }
  
  private func connectAuthFlow() {
    let authCoordinator = AuthCoordinator(self.navigationController)
    authCoordinator.delegate = self
    authCoordinator.start()
    childCoordinators.append(authCoordinator)
  }
  
  private func connectMainFlow() {
    let tabBarCoordinator = TabBarCoordinator(self.navigationController)
    tabBarCoordinator.delegate = self
    tabBarCoordinator.start()
    childCoordinators.append(tabBarCoordinator)
  }
}

extension AppCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
    self.navigationController.viewControllers.removeAll()
    
    switch childCoordinator.type {
    case .auth:
      self.connectMainFlow()
    case .tab:
      self.connectAuthFlow()
    default:
      break
    }
  }
}
