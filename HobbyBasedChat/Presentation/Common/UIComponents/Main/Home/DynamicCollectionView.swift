//
//  DynamicCollectionView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit

class DynamicCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if bounds.size != intrinsicContentSize {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }
}
