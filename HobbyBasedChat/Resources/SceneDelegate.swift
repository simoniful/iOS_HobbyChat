//
//  SceneDelegate.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isSingUpCompleted") {
            window?.rootViewController = MainTabBarController()
        } else if UserDefaults.standard.bool(forKey: "isSMSAuthCompleted") {
            window?.rootViewController = UINavigationController(rootViewController: NicknameFillOutViewController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

