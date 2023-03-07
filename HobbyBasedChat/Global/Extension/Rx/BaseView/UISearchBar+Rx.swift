//
//  UISearchBar+Rx.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UISearchBar {
  var searhBarTapWithText: Signal<String> {
    return searchButtonClicked
      .withLatestFrom(self.text.orEmpty)
      .asSignal(onErrorJustReturn: "")
  }
}
