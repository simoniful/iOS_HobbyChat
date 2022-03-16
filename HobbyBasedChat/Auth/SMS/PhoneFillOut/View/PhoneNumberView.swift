//
//  PhoneFillOutView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import UIKit
import SnapKit

class PhoneNumberView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let phoneNumTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let requireSmsButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var attText = AttributedString.init("인증 문자 받기")
        attText.font = R.font.notoSansCJKkrMedium(size: 14)
        configuration.attributedTitle = attText
        configuration.baseBackgroundColor = R.color.grayscale_gray5()
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
        addSubview(phoneNumTextFiled)
        addSubview(requireSmsButton)
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
        }
        
        phoneNumTextFiled.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        requireSmsButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumTextFiled.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
    }
}
