//
//  TabBarCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import UIKit

final class TabBarCoordinator: Coordinator {
  
  weak var delegate: CoordinatorDelegate?
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var tabBarController: UITabBarController
  var type: CoordinatorStyleCase = .tab
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    navigationController.setNavigationBarHidden(true, animated: false)
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    
  }
}

extension TabBarCoordinator: CoordinatorDelegate {
  
  func didFinish(childCoordinator: Coordinator) {
    self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    if childCoordinator.type == .myPage {
      self.navigationController.viewControllers.removeAll()
      self.delegate?.didFinish(childCoordinator: self)
    }
  }
}
