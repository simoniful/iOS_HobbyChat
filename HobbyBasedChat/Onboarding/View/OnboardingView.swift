//
//  OnboardingView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/12.
//

import UIKit
import SnapKit
import Rswift

class OnBoardingView: UIView, ViewRepresentable {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var attText = AttributedString.init("μμνκΈ°")
        attText.font = R.font.notoSansCJKkrMedium(size: 14)
        configuration.attributedTitle = attText
        configuration.baseBackgroundColor = R.color.brandcolor_green()
        configuration.baseForegroundColor = R.color.custom_white()
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.backgroundColor = .white
        addSubview(containerView)
        addSubview(startButton)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
    }
}
