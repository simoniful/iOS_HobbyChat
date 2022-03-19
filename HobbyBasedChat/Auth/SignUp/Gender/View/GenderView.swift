//
//  GenderView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/19.
//

import UIKit
import Rswift

class GenderView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "성별을 선택해 주세요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let subInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "새싹 찾기 기능을 이용하기 위해서 필요해요!", lineHeight: 25.6)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.grayscale_gray7()
        return label
    }()
    
    let horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        view.distribution = .fillEqually
        return view
    }()
    
    let maleButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = R.image.maleIcon()?.resize(newWidth: 64)
        configuration.imagePlacement = .top
        configuration.baseBackgroundColor = R.color.custom_white()
        configuration.baseForegroundColor = R.color.custom_black()
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration.title = "남자"
        let handler: UIButton.ConfigurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.baseBackgroundColor = R.color.brandcolor_whitegreen()
                default:
                    button.configuration?.baseBackgroundColor = R.color.custom_white()
                }
        }
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.configurationUpdateHandler = handler
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderColor = R.color.grayscale_gray3()
        button.layer.borderWidth = 1
        return button
    }()
    
    let femaleButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = R.image.femaleIcon()?.resize(newWidth: 64)
        configuration.imagePlacement = .top
        configuration.baseBackgroundColor = R.color.custom_white()
        configuration.baseForegroundColor = R.color.custom_black()
         configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration.title = "여자"
        let handler: UIButton.ConfigurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.baseBackgroundColor = R.color.brandcolor_whitegreen()
                default:
                    button.configuration?.baseBackgroundColor = R.color.custom_white()
                }
        }
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.configurationUpdateHandler = handler
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderColor = R.color.grayscale_gray3()?.cgColor
        button.layer.borderWidth = 1
        return button
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
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(maleButton)
        horizontalStack.addArrangedSubview(femaleButton)
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
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalTo(subInfoLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(120)
        }
        
        nextStepButton.snp.makeConstraints {
            $0.top.equalTo(horizontalStack.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
    }
}
