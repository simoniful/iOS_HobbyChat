//
//  ShopMainViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import StoreKit

final class ShopMainViewController: BaseViewController {
  private let sesacVC = ShopSesacItemViewController(
    viewModel: ShopSesacItemViewModel(
      useCase: ShopSesacItemUseCase(
        userRepository: UserRepository(),
        fireBaseRepository: FirebaseRepository(),
        sesacRepository: SesacRepository(),
        inAppRepository: InAppRepository()
      )
    )
  )
  
  private let backgroundVC = ShopBackgroundItemViewController(
    viewModel: ShopBackgroundItemViewModel(
      useCase: ShopBackgroundItemUseCase(
        userRepository: UserRepository(),
        fireBaseRepository: FirebaseRepository(),
        sesacRepository: SesacRepository(),
        inAppRepository: InAppRepository()
      )
    )
  )
  
  private let sesacView = SesacCardProfileView()
  private let sesacButton = TabButton(title: "새싹", isSelected: true)
  private let backgroundButton = TabButton(title: "배경")
  private let saveButton = BaseButton(title: "저장하기")
  private let underBarView = UIView()
  private let slidingBarView = UIView()
  private let containerView = UIView()
  
  private lazy var input = ShopMainViewModel.Input(
    viewDidLoad: Observable.just(()),
    sesacButtonTap: sesacButton.rx.tap.asSignal(),
    backgroundButtonTap: backgroundButton.rx.tap.asSignal(),
    saveButtonTap: saveButton.rx.tap.asSignal(),
    sesacItemTap: sesacItemTap.asSignal(),
    backgroundItemTap: backgroundItemTap.asSignal(),
    purchaseSesacProduct: purchaseSesacProduct.asSignal(),
    purchaseBackgroundProduct: purchaseBackgroundProduct.asSignal()
  )
  private lazy var output = viewModel.transform(input: input)
  private let viewModel: ShopMainViewModel
  
  private let sesacItemTap = PublishRelay<SesacImageCase>()
  private let backgroundItemTap = PublishRelay<SesacBackgroundCase>()
  private let purchaseSesacProduct = PublishRelay<SesacImageCase>()
  private let purchaseBackgroundProduct = PublishRelay<SesacBackgroundCase>()
  
  private var sesacCollectionList = [Int]()
  private var backgroundCollectionList = [Int]()
  
  init(viewModel: ShopMainViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("SesacShopViewController: fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttributes()
    setupView()
    bind()
    setupConstraints()
  }
  
  override func bind() {
    output.profileSesac
      .map { $0.image }
      .drive(self.sesacView.sesacImageView.rx.image)
      .disposed(by: disposeBag)
    
    output.profileBackground
      .map { $0.image }
      .drive(self.sesacView.backgroundImageView.rx.image)
      .disposed(by: disposeBag)
    
    output.showSesacListAction
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        self.sesacButton.isSelected = true
        self.backgroundButton.isSelected = false
        self.underBarSlideAnimation(moveX: 0)
        self.changeViewToSesacView()
      })
      .disposed(by: disposeBag)
    
    output.showBackgroundListAction
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        self.backgroundButton.isSelected = true
        self.sesacButton.isSelected = false
        self.underBarSlideAnimation(moveX: UIScreen.main.bounds.width / 2)
        self.changeViewToBackgroundView()
      })
      .disposed(by: disposeBag)
    
    output.sesacCollectionList
      .drive(onNext: { [weak self] list in
        self?.sesacCollectionList = list
      })
      .disposed(by: disposeBag)
    
    output.backgroundCollectionList
      .drive(onNext: { [weak self] list in
        self?.backgroundCollectionList = list
      })
      .disposed(by: disposeBag)
    
    output.showToastAction
      .emit(onNext: { [weak self] text in
        self?.view.makeToast(text, position: .top)
      })
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(sesacView)
    view.addSubview(saveButton)
    view.addSubview(sesacButton)
    view.addSubview(backgroundButton)
    view.addSubview(underBarView)
    view.addSubview(containerView)
    underBarView.addSubview(slidingBarView)
  }
  
  override func setupConstraints() {
    sesacView.snp.makeConstraints { make in
      make.left.top.equalTo(view.safeAreaLayoutGuide).offset(16)
      make.right.equalToSuperview().offset(-16)
      make.height.equalTo(175)
    }
    saveButton.snp.makeConstraints { make in
      make.top.equalTo(sesacView.snp.top).offset(12)
      make.right.equalTo(sesacView.snp.right).offset(-12)
      make.width.equalTo(80)
      make.height.equalTo(40)
    }
    sesacButton.snp.makeConstraints { make in
      make.top.equalTo(sesacView.snp.bottom)
      make.left.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
      make.height.equalTo(45)
    }
    backgroundButton.snp.makeConstraints { make in
      make.top.equalTo(sesacView.snp.bottom)
      make.right.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
      make.height.equalTo(45)
    }
    underBarView.snp.makeConstraints { make in
      make.top.equalTo(sesacButton.snp.bottom)
      make.right.left.equalToSuperview()
      make.height.equalTo(2)
    }
    slidingBarView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
    }
    containerView.snp.makeConstraints { make in
      make.top.equalTo(underBarView.snp.bottom)
      make.right.left.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setupAttributes() {
    underBarView.backgroundColor = .gray2
    slidingBarView.backgroundColor = .green
    saveButton.isValid = true
    sesacVC.delegate = self
    backgroundVC.delegate = self
  }
  
  private func changeViewToSesacView() {
    for view in self.containerView.subviews {
      view.removeFromSuperview()
    }
    sesacVC.sesacCollectionList = sesacCollectionList
    sesacVC.willMove(toParent: self)
    self.containerView.addSubview(sesacVC.view)
    sesacVC.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.addChild(sesacVC)
    sesacVC.didMove(toParent: self)
  }
  
  private func changeViewToBackgroundView() {
    for view in self.containerView.subviews {
      view.removeFromSuperview()
    }
    backgroundVC.backgroundCollection = backgroundCollectionList
    backgroundVC.willMove(toParent: self)
    self.containerView.addSubview(backgroundVC.view)
    backgroundVC.view.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.left.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-8)
    }
    self.addChild(backgroundVC)
    backgroundVC.didMove(toParent: self)
  }
  
  private func underBarSlideAnimation(moveX: CGFloat){
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8,initialSpringVelocity: 1, options: .allowUserInteraction, animations: { [weak self] in
      self?.slidingBarView.transform = CGAffineTransform(translationX: moveX, y: 0)
    }, completion: nil)
  }
}


extension ShopMainViewController: ShopPreviewDelegate {
  func updateSesac(sesac: SesacImageCase) {
    sesacItemTap.accept(sesac)
  }
  
  func updateBackground(background: SesacBackgroundCase) {
    backgroundItemTap.accept(background)
  }
  
  func transmitPurchaseSesacProduct(sesac: SesacImageCase) {
    purchaseSesacProduct.accept(sesac)
  }
  
  func transmitPurchaseBackgroundProduct(background: SesacBackgroundCase) {
    purchaseBackgroundProduct.accept(background)
  }
}
