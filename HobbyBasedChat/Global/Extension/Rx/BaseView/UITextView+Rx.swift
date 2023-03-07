//
//  UITextView+Rx.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit.UITextView
import RxCocoa
import RxSwift

extension Reactive where Base: UITextView {
  var isText: Observable<Bool> {
    return text
      .orEmpty
      .map {
        return $0 != "" && base.textColor != .gray7
      }
  }
}
