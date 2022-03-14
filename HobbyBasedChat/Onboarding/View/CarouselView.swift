//
//  CarouselView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/12.
//

import UIKit
import Rswift
import SnapKit

class CarouselView: UIView, ViewRepresentable {
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.notoSansCJKkrMedium(size: 24)
        label.setTextWithLineHeight(text: "", lineHeight: 38.4)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.custom_black()
        return label
    }()
    
    let infoImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        self.backgroundColor = R.color.custom_white()
        addSubview(infoLabel)
        addSubview(infoImage)
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(72)
            $0.centerX.equalToSuperview()
        }
        
        infoImage.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(90)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(infoImage.snp.width).multipliedBy(1.0 / 1.0)
        }
    }
}
