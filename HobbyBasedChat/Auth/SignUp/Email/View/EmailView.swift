//
//  EmailView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/17.
//

import UIKit
import Rswift

class EmailFillOutView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "이메일을 입력해 주세요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let subInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "휴대폰 번호 변경 시 인증을 위해 사용해요", lineHeight: 25.6)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.grayscale_gray7()
        return label
    }()
    
    let emailTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "SeSac@email.com"
        textField.textContentType = .emailAddress
        textField.keyboardType = .default
        return textField
    }()
    
    let nextStepButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var attText = AttributedString.init("다음")
        attText.font = R.font.notoSansCJKkrMedium(size: 14)
        configuration.attributedTitle = attText
        configuration.baseBackgroundColor = R.color.grayscale_gray6()
        configuration.baseForegroundColor = R.color.grayscale_gray3()
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        addSubview(emailTextFiled)
        addSubview(nextStepButton)
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
        
        emailTextFiled.snp.makeConstraints {
            $0.top.equalTo(subInfoLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        nextStepButton.snp.makeConstraints {
            $0.top.equalTo(emailTextFiled.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
    }
}
