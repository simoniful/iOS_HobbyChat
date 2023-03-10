//
//  ShopSesacItemCell.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit
import RxSwift

final class ShopSesacItemCell: UICollectionViewCell {
  static let identifier = "ShopSesacItemCell"
  
  private let imageView = UIImageView()
  private let titleLabel = BaseLabel(font: .title2R16, textColor: .black)
  private let contentLabel = BaseLabel(font: .body3R14, textColor: .black)
  let priceButton = PriceButton()
  
  var disposeBag = DisposeBag()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    contentView.addSubview(imageView)
    contentView.addSubview(priceButton)
    contentView.addSubview(titleLabel)
    contentView.addSubview(contentLabel)
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.height.equalTo(imageView.snp.width)
    }
    priceButton.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(12)
      make.right.equalToSuperview()
      make.width.equalTo(52)
      make.height.equalTo(20)
    }
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(8)
      make.left.equalToSuperview()
      make.right.equalTo(priceButton.snp.left).offset(8)
      make.height.equalTo(26)
    }
    contentLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.left.bottom.right.equalToSuperview()
    }
  }
  
  private func setupAttributes() {
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = UIColor.gray4.cgColor
    imageView.layer.cornerRadius = 8
    titleLabel.textAlignment = .left
    contentLabel.textAlignment = .natural
  }
  
  func updateUI(sesac: SesacImageCase, isHaving: Int) {
    imageView.image = sesac.image
    titleLabel.text = sesac.name
    contentLabel.text = sesac.content
    if isHaving == 1 {
      priceButton.setDefault()
    } else {
      priceButton.setNotHaving(text: sesac.price)
    }
  }
}
