//
//  MyPageMainViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit

final class MyPageMainViewController: BaseViewController, UIGestureRecognizerDelegate {
  
  private weak var coordinator: MyPageCoordinator?
  private let tableView = UITableView()
  
  init(coordinator: MyPageCoordinator) {
    self.coordinator = coordinator
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("NickNameVC fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    setupAttributes()
  }
  
  @objc
  private func headerViewTap(_ sender: UITapGestureRecognizer) {
    coordinator?.showMyPageEditViewController()
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
    navigationItem.backButtonTitle = ""
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MyPageMainCell.self,
                       forCellReuseIdentifier: MyPageMainCell.identifier)
    tableView.register(MyPageMainHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: MyPageMainHeaderView.identifier)
    tableView.separatorStyle = .singleLine
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    if #available(iOS 15.0, *) {
      tableView.sectionHeaderTopPadding = 1
    }
  }
}

extension MyPageMainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MyPageMainCase.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageMainCell.identifier, for: indexPath) as? MyPageMainCell else {
      return UITableViewCell()
    }
    cell.setData(menu: MyPageMainCase.allCases[indexPath.row])
    return cell
  }
}

extension MyPageMainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerView = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: MyPageMainHeaderView.identifier
    ) as? MyPageMainHeaderView
    else {
      return UITableViewHeaderFooterView()
    }
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(self.headerViewTap)
    )
    tap.delegate = self
    headerView.addGestureRecognizer(tap)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return MyPageMainCell.height
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyPageMainHeaderView.height
  }
}
