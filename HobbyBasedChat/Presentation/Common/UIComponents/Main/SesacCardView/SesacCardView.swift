//
//  SesacCardView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import SnapKit

final class SesacCardView: UIView {
    let previewView = SesacCardPreviewView()
    private let titleLabel = BaseLabel(title: "새싹 타이틀", font: .title4R14)
    private let sesacTitleView = SesacCardTitleView()
    let sesacHobbyView = SesacCardHobbyView()
    let sesacReviewView = SesacCardReviewView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        setConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("SesacCardView: fatal error")
    }

    private func setConstraints() {
        addSubview(previewView)
        addSubview(titleLabel)
        addSubview(sesacTitleView)
        addSubview(sesacHobbyView)
        addSubview(sesacReviewView)
        previewView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(previewView.snp.bottom)
            make.height.equalTo(40)
        }
        sesacTitleView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(156)
        }
        sesacHobbyView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sesacReviewView.snp.top).priority(.low)
        }
        sesacReviewView.snp.makeConstraints { make in
            make.top.equalTo(sesacHobbyView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
        }
    }

    private func setConfiguration(){
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor.gray4.cgColor
        layer.borderWidth = 1
        titleLabel.textAlignment = .left
    }

    func setNickname(nickname text: String){
        previewView.setNickname(nickname: text)
    }

    func setReviewText(text: String) {
        sesacReviewView.setText(text: text)
    }

    func setPlaceHolder() {
        sesacReviewView.setPlaceHolder()
    }

    func setSesacTitle(reputation: [Int]) {
        sesacTitleView.setSesacTitle(reputation: reputation)
    }

    func setToggleButtonImage(isToggle: Bool) {
        previewView.setToggleButtonImage(isToggle: isToggle)
    }
}
