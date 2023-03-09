//
//  HomeCoordinator.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class HomeCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .home

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
//        UserDefaults.standard.set(MatchStatus.general.rawValue, forKey: UserDefaultKeyCase.matchStatus)
    }

    func start() {
        let vc = HomeMainViewController(
            viewModel: HomeMainViewModel(
                coordinator: self,
                homeUseCase: HomeUseCase(
                    userRepository: UserRepository(),
                    fireBaseRepository: FirebaseRepository(),
                    sesacRepository: SesacRepository()
                )
            )
        )
        navigationController.pushViewController(vc, animated: true)
    }

    func showHomeSearchViewController(coordinate: Coordinate) {
        let vc = HomeHobbySettingViewController(
            viewModel: HomeHobbySettingViewModel(
                coordinator: self,
                useCase: HomeHobbySettingUseCase(
                    userRepository: UserRepository(),
                    fireBaseRepository: FirebaseRepository(),
                    sesacRepository: SesacRepository()
                ),
                coordinate: coordinate
            )
        )
        vc.hidesBottomBarWhenPushed = true
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }

    func changeTabToMyPageViewController(message: String) {
        navigationController.tabBarController?.selectedIndex = 3
        navigationController.tabBarController?.view.makeToast(message, position: .top)
    }
    
    func popToRootViewController(message: String? = nil) {
        navigationController.popToRootViewController(animated: true)
        if let message = message {
            navigationController.view.makeToast(message, position: .top)
        }
    }
}
