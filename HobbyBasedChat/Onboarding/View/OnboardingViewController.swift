//
//  OnboardingViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//


import UIKit

class OnBoardingViewController: UIViewController {
    let onBoardingView = OnBoardingView()
    
    override func loadView() {
        super.loadView()
        self.view = onBoardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageVC()
        onBoardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        self.navigationController?.pushViewController(PhoneFillOutViewController(), animated: true)
    }
    
    func setupPageVC() {
        let pageVC = OnboardingPageViewController()
        addChild(pageVC)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        onBoardingView.containerView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints {
            $0.edges.equalTo(onBoardingView.containerView.snp.edges)
        }
        pageVC.didMove(toParent: self)
    }
}
