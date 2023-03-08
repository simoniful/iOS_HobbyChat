//
//  MyPageCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class MyPageCoordinator: Coordinator {
  weak var delegate: CoordinatorDelegate?
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  var type: CoordinatorStyleCase = .myPage
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = MyPageMainViewController(coordinator: self)
    vc.title = "내정보"
    navigationController.pushViewController(vc, animated: true)
  }
  
  func showMyPageEditViewController() {
    let vc = MyPageUpdateViewController(
      viewModel: MyPageUpdateViewModel(
        coordinator: self,
        myPageEditUseCase: MyPageUpdateUseCase(
          userRepository: UserRepository(),
          fireBaseRepository: FirebaseRepository(),
          sesacRepository: SesacRepository()
        )
      )
    )
    vc.title = "정보 관리"
    vc.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(vc, animated: true)
  }
  
  func popMyPageEditViewController(message: String) {
    navigationController.popViewController(animated: true)
    navigationController.view.makeToast(message, position: .top)
  }
}
