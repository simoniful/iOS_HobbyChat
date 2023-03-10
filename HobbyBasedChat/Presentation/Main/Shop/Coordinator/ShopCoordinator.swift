//
//  ShopCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class ShopCoordinator: Coordinator {
  weak var delegate: CoordinatorDelegate?
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var type: CoordinatorStyleCase = .sesacShop
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = ShopMainViewController(
      viewModel: ShopMainViewModel(
        coordinator: self,
        useCase: ShopUseCase(
          userRepository: UserRepository(),
          fireBaseRepository: FirebaseRepository(),
          sesacRepository: SesacRepository()
        )
      )
    )
    vc.title = "새싹샵"
    navigationController.pushViewController(vc, animated: true)
  }
}
