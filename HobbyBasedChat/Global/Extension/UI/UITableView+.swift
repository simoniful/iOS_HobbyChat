//
//  UITableView+.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit.UITableView
import SnapKit

extension UITableView {
  func setNoDataPlaceholder(
    title: String,
    message: String
  ) {
    self.backgroundView = BaseTableViewBackgroundView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: self.bounds.width,
        height: self.bounds.height
      ),
      title: title,
      message: message
    )
    self.isScrollEnabled = false
    self.separatorStyle = .none
  }
  
  func removeNoDataPlaceholder() {
    self.isScrollEnabled = true
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
