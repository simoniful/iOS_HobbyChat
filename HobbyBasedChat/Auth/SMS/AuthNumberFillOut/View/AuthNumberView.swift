//
//  AuthNumberFillOutView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//


import UIKit
import Rswift

class AuthNumberView: UIView, ViewRepresentable {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "인증번호가 문자로 전송되었어요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let subInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "(최대 소모 20초)", lineHeight: 25.6)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.grayscale_gray7()
        return label
    }()
    
    let horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fill
        return view
    }()
    
    let authNumTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "인증번호 입력"
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrMedium(size: 14)
        label.setTextWithLineHeight(text: "", lineHeight: 22.4)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.brandcolor_green()
        return label
    }()
    
    let retryButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var attText = AttributedString.init("재전송")
        attText.font = R.font.notoSansCJKkrMedium(size: 14)
        configuration.attributedTitle = attText
        configuration.baseBackgroundColor = R.color.brandcolor_green()
        configuration.baseForegroundColor = R.color.custom_white()
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        return button
    }()
    
    let authAndStartButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var attText = AttributedString.init("인증하고 시작하기")
        attText.font = R.font.notoSansCJKkrMedium(size: 14)
        configuration.attributedTitle = attText
        configuration.baseBackgroundColor = R.color.grayscale_gray6()
        configuration.baseForegroundColor = R.color.grayscale_gray3()
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
        addSubview(infoLabel)
        addSubview(subInfoLabel)
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(authNumTextFiled)
        horizontalStack.addArrangedSubview(retryButton)
        addSubview(timerLabel)
        addSubview(authAndStartButton)
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(72)
            $0.height.equalTo(40)
        }
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalTo(subInfoLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        authAndStartButton.snp.makeConstraints {
            $0.top.equalTo(horizontalStack.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
        
        timerLabel.snp.makeConstraints {
            $0.trailing.equalTo(authNumTextFiled.snp.trailing).offset(-12)
            $0.centerY.equalTo(retryButton.snp.centerY).offset(-3)
        }
    }
    
    
}
