//
//  NicknameVIew.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import UIKit
import Rswift
import SnapKit

class NicknameView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "닉네임을 입력해 주세요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let nicknameTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "10자 이내로 입력"
        textField.textContentType = .nickname
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
        addSubview(nicknameTextFiled)
        addSubview(nextStepButton)
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
        }
        
        nicknameTextFiled.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        nextStepButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextFiled.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
    }
}
