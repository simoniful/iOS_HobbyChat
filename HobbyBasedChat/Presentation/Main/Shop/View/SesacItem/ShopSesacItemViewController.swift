//
//  ShopSesacItemViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

final class ShopSesacItemViewController: BaseViewController {
  weak var delegate: ShopPreviewDelegate?
  var sesacCollectionList = [Int]()
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private lazy var input = ShopSesacItemViewModel.Input(
    viewDidLoad: Observable.just(()),
    priceButtonTap: priceButtonTap.asSignal()
  )
  private lazy var output = viewModel.transform(input: input)
  private let viewModel: ShopSesacItemViewModel
  
  private let priceButtonTap = PublishRelay<Int>()
  
  init(viewModel: ShopSesacItemViewModel) {
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
    output.indicatorAction
      .drive(onNext: {
        $0 ? IndicatorView.shared.show(backgoundColor: Asset.transparent.color) : IndicatorView.shared.hide()
      })
      .disposed(by: disposeBag)
    
    output.sesacLists
      .drive(collectionView.rx.items(cellIdentifier: ShopSesacItemCell.identifier, cellType: ShopSesacItemCell.self)) { [weak self] index, sesac, cell in
        guard let self = self else { return }
        cell.updateUI(sesac: sesac, isHaving: self.sesacCollectionList[index])
        cell.priceButton.rx.tap.asSignal()
          .filter { self.sesacCollectionList[index] == 1 ? false : true}
          .map { index }
          .emit(to: self.priceButtonTap)
          .disposed(by: cell.disposeBag)
      }
      .disposed(by: disposeBag)
    
    output.successPurchaseProduct
      .emit(onNext: { [weak self] sesac in
        guard let self = self else { return }
        self.sesacCollectionList[sesac.rawValue] = 1
        self.delegate?.transmitPurchaseSesacProduct(sesac: sesac)
        self.collectionView.reloadItems(at: [IndexPath(item: sesac.rawValue, section: 0)])
      })
      .disposed(by: disposeBag)
    
    collectionView.rx.modelSelected(SesacImageCase.self)
      .asSignal()
      .emit(onNext: { [weak self] item in
        self?.delegate?.updateSesac(sesac: item)
      })
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(collectionView)
  }
  
  override func setupConstraints() {
    collectionView.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(16)
      make.right.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview()
    }
  }
  
  private func setupAttributes() {
    collectionView.register(ShopSesacItemCell.self,
                            forCellWithReuseIdentifier: ShopSesacItemCell.identifier)
    collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    collectionView.showsVerticalScrollIndicator = false
  }
}

extension ShopSesacItemViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSpacing: CGFloat = 16
    let textAreaHeight: CGFloat = 124
    
    let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
    let height: CGFloat = width + textAreaHeight
    return CGSize(width: width, height: height)
  }
}
