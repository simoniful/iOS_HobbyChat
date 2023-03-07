//
//  OnBoardingViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import UIKit
import SnapKit

final class OnBoardingViewController: BaseViewController {
  private let scrollView = UIScrollView()
  private let pageControl = UIPageControl()
  private let descriptionLabel = UILabel()
  private let startButton = BaseButton(title: "시작하기")
  private var viewModel: OnBoardingViewModel
  
  init(viewModel: OnBoardingViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("OnBoardingViewController fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    setupAttributes()
  }
  
  override func setupView() {
    view.addSubview(scrollView)
    view.addSubview(startButton)
    view.addSubview(pageControl)
    view.addSubview(descriptionLabel)
  }
  
  override func setupConstraints() {
    
    scrollView.frame = view.bounds
    
    for i in 0..<viewModel.count {
      let scrollContentView = UIView()
      scrollView.addSubview(scrollContentView)
      let xPos = self.view.frame.width * CGFloat(i)
      scrollContentView.frame = CGRect(x: xPos,
                                       y: 0,
                                       width: scrollView.bounds.width,
                                       height: scrollView.bounds.height)
      
      let imageView = UIImageView()
      imageView.image = viewModel.onBoardingImageList(at: i)
      scrollContentView.addSubview(imageView)
      imageView.snp.makeConstraints { make in
        make.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(1.1)
        make.left.equalToSuperview().offset(30)
        make.right.equalToSuperview().offset(-30)
        make.height.equalTo(imageView.snp.width)
      }
      imageView.contentMode = .scaleAspectFill
      scrollView.contentSize.width = scrollContentView.frame.width * CGFloat(i + 1)
    }
    
    startButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(48)
    }
    pageControl.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(startButton.snp.top).offset(-42)
      make.height.equalTo(30)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(0.4)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
  }
  
  private func setupAttributes() {
    view.backgroundColor = .white
    startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
    startButton.isValid = true
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    pageControl.numberOfPages = viewModel.count
    pageControl.currentPageIndicatorTintColor = .black
    pageControl.pageIndicatorTintColor = .gray5
    
    descriptionLabel.textAlignment = .center
    descriptionLabel.numberOfLines = 0
    descriptionLabel.attributedText = viewModel.onBoardingTitleString(at: 0)
  }
  
  @objc
  private func startButtonTap() {
    viewModel.showLoginController()
  }
}

extension OnBoardingViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let value = targetContentOffset.pointee.x / scrollView.frame.size.width
    let currentPageNumber = Int(value)
    descriptionLabel.attributedText = viewModel.onBoardingTitleString(at: currentPageNumber)
    setPageControlSelectedPage(currentPage: currentPageNumber)
  }
  
  private func setPageControlSelectedPage(currentPage: Int){
    self.pageControl.currentPage = currentPage
  }
}
