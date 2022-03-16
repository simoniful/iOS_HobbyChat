//
//  BirthdayView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import UIKit
import Rswift
import SnapKit


class BirthdayView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 20)
        label.setTextWithLineHeight(text: "생년월일을 알려주세요", lineHeight: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        view.distribution = .fillEqually
        return view
    }()
    
    let yearHorizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fill
        return view
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "년", lineHeight: 25.6)
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        return label
    }()
    
    let yearTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "1990"
        textField.textContentType = .dateTime
        // textField.isUserInteractionEnabled = false
        // textField.isEnabled = false
        return textField
    }()
    
    let monthHorizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fill
        return view
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "월", lineHeight: 25.6)
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        return label
    }()
    
    let monthTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "1"
        textField.textContentType = .dateTime
        // textField.isUserInteractionEnabled = false
        // textField.isEnabled = false
        return textField
    }()
    
    let dayHorizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fill
        return view
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrRegular(size: 16)
        label.setTextWithLineHeight(text: "월", lineHeight: 25.6)
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        return label
    }()
    
    let dayTextFiled: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "1"
        textField.textContentType = .dateTime
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
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.frame.size = CGSize(width: 0, height: 200)
        return datePicker
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
        addSubview(horizontalStack)
        yearHorizontalStack.addArrangedSubview(yearTextFiled)
        yearHorizontalStack.addArrangedSubview(yearLabel)
        monthHorizontalStack.addArrangedSubview(monthTextFiled)
        monthHorizontalStack.addArrangedSubview(monthLabel)
        dayHorizontalStack.addArrangedSubview(dayTextFiled)
        dayHorizontalStack.addArrangedSubview(dayLabel)
        horizontalStack.addArrangedSubview(yearHorizontalStack)
        horizontalStack.addArrangedSubview(monthHorizontalStack)
        horizontalStack.addArrangedSubview(dayHorizontalStack)
        addSubview(nextStepButton)
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
        }
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        nextStepButton.snp.makeConstraints {
            $0.top.equalTo(horizontalStack.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(48)
        }
    }
}
