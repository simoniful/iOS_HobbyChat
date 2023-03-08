//
//  ProfileImageVIew.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit.UIImageView

final class ProfileImageView: UIImageView {
  override init(image: UIImage? = nil) {
    super.init(image: image)
    self.setupAttributes()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.width / 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("ProfileImageView: fatal error")
  }
  
  private func setupAttributes(){
    image = Asset.defaultProfile.image
    contentMode = .scaleAspectFill
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray3.cgColor
  }
  
  func setProfileImage(image: UIImage) {
    self.image = image
  }
}
