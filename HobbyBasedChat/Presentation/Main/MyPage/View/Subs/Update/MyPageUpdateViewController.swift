//
//  MyPageUpdateViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MyPageUpdateViewController: BaseViewController {
  private let headerView = MyPageUpdateHeaderView()
  private let footerView = MyPageUpdateFooterView()
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private lazy var saveBarButton = UIBarButtonItem(
    title: "저장",
    style: .plain,
    target: self,
    action: #selector(saveBarButtonTap)
  )
  private var isToggle: Bool = true
  
  private lazy var input = MyPageUpdateViewModel.Input(
    viewDidLoad: Observable.just(()).asSignal(onErrorJustReturn: ()),
    didWithdrawButtonTap: footerView.withdrawButtonTap,
    requestWithdrawSignal: requestWithdrawSignal.asSignal(),
    requestUpdateSignal: requestUpdateSignal.asSignal()
  )
  private lazy var output = viewModel.transform(input: input)
  private let viewModel: MyPageUpdateViewModel

  private let requestWithdrawSignal = PublishRelay<Void>()
  private let requestUpdateSignal = PublishRelay<UpdateUserInfo>()
  
  init(viewModel: MyPageUpdateViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("MyPageEditViewController: fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    setupAttributes()
    bind()
  }
  
  override func bind() {
    output.userInfo
      .emit(onNext: { [weak self] info in
        guard let self = self else { return }
        self.headerView.setHeaderView(info: info)
        let updateFooterInfo: UpdateUserInfo = (
          info.searchable, info.ageMin, info.ageMax, info.gender, info.hobby
        )
        self.footerView.setUserInfo(info: updateFooterInfo)
        self.tableView.reloadData()
      })
      .disposed(by: disposeBag)
    
    output.showAlertAction
      .emit(onNext: {
        [weak self] in
        let alert = AlertView.init(
          title: "정말 탈퇴하시겠습니까?",
          message: "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ",
          buttonStyle: .confirmAndCancel) { [weak self] in
            self?.requestWithdrawSignal.accept(())
          }
        alert.showAlert()
      })
      .disposed(by: disposeBag)
    
    output.indicatorAction
      .drive(onNext: {
        $0 ? IndicatorView.shared.show(backgoundColor: Asset.transparent.color) : IndicatorView.shared.hide()
      })
      .disposed(by: disposeBag)
    
    output.showToastAction
      .emit(onNext: { [unowned self] text in
        self.view.makeToast(text, position: .top)
      })
      .disposed(by: disposeBag)
  }
  
  @objc
  private func saveBarButtonTap() {
    let updateInfo = footerView.getUserInfo()
    requestUpdateSignal.accept(updateInfo)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.tableView.endEditing(true)
  }
  
  override func setupView() {
    tableView.register(MyPageUpdateHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: MyPageUpdateHeaderView.identifier)
    tableView.register(MyPageUpdateFooterView.self,
                       forHeaderFooterViewReuseIdentifier: MyPageUpdateFooterView.identifier)
    tableView.backgroundColor = .white
    navigationItem.rightBarButtonItem = saveBarButton
    view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupAttributes() {
    view.backgroundColor = .white
    tableView.delegate = self
    if #available(iOS 15.0, *) {
      tableView.sectionHeaderTopPadding = 1
    }
    headerView.toggleAddTarget(target: self, action: #selector(didPressToggle), event: .touchUpInside)
    headerView.setToggleButtonImage(isToggle: isToggle)
  }
}

extension MyPageUpdateViewController {
  
  @objc
  func didPressToggle() {
    isToggle = !isToggle
    headerView.updateConstraints(isToggle: isToggle)
    headerView.layoutIfNeeded()
    tableView.reloadSections([0], with: .none)
  }
}

extension MyPageUpdateViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let height = (UIScreen.main.bounds.width - 32) * (194.0 / 343) + 85
    return isToggle ? height : UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return UITableView.automaticDimension
  }
}
