//
//  HomeSesacSearchViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture
import RxKeyboard
import SnapKit

final class HomeSesacSearchViewController: BaseViewController {
  private let backBarButton = UIBarButtonItem()
  private let pauseSearchBarButton = UIBarButtonItem()
  private let nearSesacButton = TabButton(title: "주변 새싹", isSelected: true)
  private let receivedRequestButton = TabButton(title: "받은 요청")
  private let underBarView = UIView()
  private let slidingBarView = UIView()
  private let tableView = UITableView()
  private let bottomSheetView = UIView()
  private let refreshButton = UIButton()
  private let changeHobbyButton = SelectionButton(title: "취미 변경하기")
  
  private var toggleInfoArrays = [Bool]()
  
  private lazy var input = HomeSesacSearchViewModel.Input(
    viewWillAppear: self.rx.viewWillAppear.asSignal(),
    backBarButtonTap: backBarButton.rx.tap.asSignal(),
    pauseSearchBarButtonTap: pauseSearchBarButton.rx.tap.asSignal(),
    nearSesacButtonTap: nearSesacButton.rx.tap.asSignal(),
    receivedRequestButtonTap: receivedRequestButton.rx.tap.asSignal(),
    requestSesacFriend: requestSesacFriend.asSignal(),
    requestAcceptSesacFriend: requestAcceptSesacFriend.asSignal(),
    reviewDetailButtonTap: reviewDetailButtonTap.asSignal(),
    changeHobbyButtonTap: changeHobbyButton.rx.tap.asSignal(),
    refreshButtonTap: refreshButton.rx.tap.asSignal()
  )
  private lazy var output = viewModel.transform(input: input)
  private let viewModel: HomeSesacSearchViewModel
  
  private let requestSesacFriend = PublishRelay<String>()
  private let requestAcceptSesacFriend = PublishRelay<String>()
  private let reviewDetailButtonTap = PublishRelay<Int>()
  
  private var status: SesacSearchTabCase = .near
  
  init(viewModel: HomeSesacSearchViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("HomeSearchViewController: fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttributes()
    setupView()
    bind()
    setupConstraints()
  }
  
  override func bind() {
    output.items
      .map { return $0.count <= 0 }
      .drive(tableView.rx.isEmpty(
        title: SesacSearchTabCase.near.emptyTitle,
        message: SesacSearchTabCase.receive.emptyMessage)
      )
      .disposed(by: disposeBag)
    
    output.items
      .drive(onNext: { [weak self] items in
        self?.toggleInfoArrays = []
        items.forEach { item in
          self?.toggleInfoArrays.append(true)
        }
      })
      .disposed(by: disposeBag)
    
    output.items
      .drive(tableView.rx.items) { [weak self] tv, index, element in
        guard let self = self else { return UITableViewCell() }
        let cell = tv.dequeueReusableCell(withIdentifier: HomeSesacSeachCardCell.identifier) as! HomeSesacSeachCardCell
        switch self.status {
        case .near:
          cell.updateUI(item: element, tabStatus: .near)
          cell.requestButton.rx.tap.asSignal()
            .map { element.userID }
            .emit(to: self.requestSesacFriend)
            .disposed(by: cell.disposeBag)
          cell.updateConstraints(isToggle: self.toggleInfoArrays[index])
        case .receive:
          cell.updateUI(item: element, tabStatus: .receive)
          cell.receiveButton.rx.tap.asSignal()
            .map { return element.userID }
            .emit(to: self.requestAcceptSesacFriend)
            .disposed(by: cell.disposeBag)
          cell.updateConstraints(isToggle: self.toggleInfoArrays[index])
        }
        
        cell.cardView.sesacReviewView.toggleButton.rx.tap.asSignal()
          .map { index }
          .emit(to: self.reviewDetailButtonTap)
          .disposed(by: cell.disposeBag)
        
        cell.cardView.previewView.toggleButton.rx.tap
          .bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.toggleInfoArrays[index] = !self.toggleInfoArrays[index]
            UIView.performWithoutAnimation {
              self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            }
          })
          .disposed(by: cell.disposeBag)
        return cell
      }
      .disposed(by: disposeBag)
    
    output.items
      .map { return !($0.count <= 0) }
      .drive(bottomSheetView.rx.isHidden)
      .disposed(by: disposeBag)
    
    output.showToastAction
      .emit(onNext: { [unowned self] message in
        self.view.makeToast(message, position: .top)
      })
      .disposed(by: disposeBag)
    
    output.indicatorAction
      .drive(onNext: {
        $0 ? IndicatorView.shared.show(backgoundColor: .white) : IndicatorView.shared.hide()
      })
      .disposed(by: disposeBag)
    
    output.tabStatus
      .drive(onNext: { [weak self] status in
        guard let self = self else { return }
        switch status {
        case .near:
          self.status = .near
          self.nearSesacButton.isSelected = true
          self.receivedRequestButton.isSelected = false
          self.underBarSlideAnimation(moveX: 0)
        case .receive:
          self.status = .receive
          self.receivedRequestButton.isSelected = true
          self.nearSesacButton.isSelected = false
          self.underBarSlideAnimation(moveX: UIScreen.main.bounds.width / 2)
        }
      })
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(nearSesacButton)
    view.addSubview(receivedRequestButton)
    view.addSubview(underBarView)
    view.addSubview(tableView)
    view.addSubview(bottomSheetView)
    underBarView.addSubview(slidingBarView)
    bottomSheetView.addSubview(refreshButton)
    bottomSheetView.addSubview(changeHobbyButton)
  }
  
  override func setupConstraints() {
    nearSesacButton.snp.makeConstraints { make in
      make.top.left.equalTo(view.safeAreaLayoutGuide)
      make.width.equalToSuperview().multipliedBy(0.5)
      make.height.equalTo(45)
    }
    receivedRequestButton.snp.makeConstraints { make in
      make.top.right.equalTo(view.safeAreaLayoutGuide)
      make.width.equalToSuperview().multipliedBy(0.5)
      make.height.equalTo(45)
    }
    underBarView.snp.makeConstraints { make in
      make.top.equalTo(nearSesacButton.snp.bottom)
      make.right.left.equalToSuperview()
      make.height.equalTo(2)
    }
    tableView.snp.makeConstraints { make in
      make.top.equalTo(underBarView.snp.bottom)
      make.left.right.bottom.equalToSuperview()
    }
    slidingBarView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
    }
    bottomSheetView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.height.equalTo(48)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
    }
    refreshButton.snp.makeConstraints { make in
      make.bottom.top.equalToSuperview()
      make.right.equalToSuperview().offset(-16)
      make.width.equalTo(refreshButton.snp.height)
    }
    changeHobbyButton.snp.makeConstraints { make in
      make.bottom.top.equalToSuperview()
      make.left.equalToSuperview().offset(16)
      make.right.equalTo(refreshButton.snp.left).offset(-16)
    }
  }
  
  private func setupAttributes() {
    view.backgroundColor = .white
    navigationItem.backButtonTitle = ""
    navigationItem.rightBarButtonItem = pauseSearchBarButton
    navigationItem.leftBarButtonItem = backBarButton
    pauseSearchBarButton.title = "찾기 중단"
    pauseSearchBarButton.style = .plain
    backBarButton.image = Asset.backNarrow.image
    backBarButton.style = .plain
    underBarView.backgroundColor = .gray2
    slidingBarView.backgroundColor = .green
    changeHobbyButton.isSelected = true
    refreshButton.setImage(Asset.refresh.image, for: .normal)
    refreshButton.layer.borderWidth = 1
    refreshButton.layer.borderColor = UIColor.green.cgColor
    refreshButton.layer.cornerRadius = 8
    tableView.register(HomeSesacSeachCardCell.self, forCellReuseIdentifier: HomeSesacSeachCardCell.identifier)
    tableView.rx.setDelegate(self).disposed(by: disposeBag)
    tableView.estimatedRowHeight = 400
    tableView.separatorColor = .clear
    bottomSheetView.isHidden = true
  }
  
  private func underBarSlideAnimation(moveX: CGFloat){
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 1, options: .allowUserInteraction, animations: { [weak self] in
      self?.slidingBarView.transform = CGAffineTransform(translationX: moveX, y: 0)
    }, completion: nil)
  }
}

extension HomeSesacSearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = (UIScreen.main.bounds.width - 32) * (194.0 / 343) + 85
    return toggleInfoArrays[indexPath.row] ? UITableView.automaticDimension : height
  }
}
