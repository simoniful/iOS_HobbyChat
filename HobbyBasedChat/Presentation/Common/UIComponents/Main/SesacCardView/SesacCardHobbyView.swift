//
//  SesacCardHobbyView.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import RxCocoa
import RxSwift

final class SesacCardHobbyView: UIView, UIScrollViewDelegate {
  private let titleLabel = BaseLabel(title: "하고 싶은 취미", font: .title4R14)
  lazy var collectionView: DynamicCollectionView = {
    let layout = CollectionViewLeftAlignFlowLayout()
    layout.headerReferenceSize = CGSize(width: 0, height: 0)
    let collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  let hobbyLists = PublishRelay<[String]>()
  var disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttributes()
    setupConstraints()
    bind()
  }
  
  required init(coder: NSCoder) {
    fatalError("SesacReviewView: fatal error")
  }
  
  private func bind() {
    self.hobbyLists
      .asDriver(onErrorJustReturn: [])
      .drive(collectionView.rx.items(cellIdentifier: HobbyCell.identifier, cellType: HobbyCell.self)) { index, hobby, cell in
        if hobby == "anything" || hobby == "Anything" {
          cell.updateUI(hobby: "아무거나")
        } else {
          cell.updateUI(hobby: hobby)
        }
      }
      .disposed(by: disposeBag)
  }
  
  private func setupConstraints() {
    addSubview(titleLabel)
    addSubview(collectionView)
    titleLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.top.equalToSuperview()
      make.height.equalTo(40)
    }
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.left.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview().offset(-16)
    }
  }
  
  private func setupAttributes() {
    collectionView.register(HobbyCell.self,
                            forCellWithReuseIdentifier: HobbyCell.identifier)
    titleLabel.textAlignment = .left
    collectionView.isScrollEnabled = false
  }
}
