//
//  HomeReviewDetailViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class HomeReviewDetailViewController: BaseViewController {
  private let tableView = UITableView()
  private let reviews: BehaviorRelay<[String]>
  
  init(reviews: [String]) {
    self.reviews = BehaviorRelay<[String]>(value: reviews)
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("ReviewDetailViewController: fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttributes()
    setupView()
    setupConstraints()
    bind()
  }
  
  override func bind() {
    reviews.asDriver()
      .drive(tableView.rx.items) { tv, index, element in
        let cell = tv.dequeueReusableCell(withIdentifier: HomeReviewDetailCell.identifier) as! HomeReviewDetailCell
        cell.updateUI(review: element)
        return cell
      }
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupAttributes() {
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.register(HomeReviewDetailCell.self,
                       forCellReuseIdentifier: HomeReviewDetailCell.identifier)
  }
}
