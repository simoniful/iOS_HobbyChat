//
//  SesacProfileView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import SnapKit

final class SesacCardProfileView: UIView {
  let backgroundImageView = UIImageView()
  let sesacImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupAttributes()
  }
  
  required init?(coder: NSCoder) {
    fatalError("ProfileImageView: fatal error")
  }
  
  private func setupConstraints() {
    addSubview(backgroundImageView)
    addSubview(sesacImageView)
    backgroundImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    sesacImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.width.height.equalTo(self.snp.width).multipliedBy(0.53)
      make.bottom.equalToSuperview().offset(9)
    }
  }
  
  private func setupAttributes(){
    backgroundImageView.image = Asset.defaultBackground.image
    sesacImageView.image = Asset.defaultSesac.image
    sesacImageView.contentMode = .scaleToFill
    backgroundImageView.contentMode = .scaleToFill
    layer.masksToBounds = true
    layer.cornerRadius = 8
  }
  
  func setBackgroundImage(image: UIImage) {
    backgroundImageView.image = image
  }
  
  func setSesacImage(image: UIImage) {
    sesacImageView.image = image
  }
}
