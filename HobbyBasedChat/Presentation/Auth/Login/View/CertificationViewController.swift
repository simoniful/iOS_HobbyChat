//
//  CertificationViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit
import RxCocoa
import RxSwift

final class CertificationViewController: BaseViewController {
  private let descriptionLabel = BaseLabel(title: "인증번호가 문자로 전송되었어요", font: .display1R20)
  private let timeLimitLabel = UILabel()
  private let authNumberTextField = BaseTextField(placeHolder: "인증번호 입력")
  private let transferButton = BaseButton(title: "재전송")
  private let startButton = BaseButton(title: "인증하고 시작하기")
  
  private lazy var input = CertificationViewModel.Input(
    startButtonTapSignal: startButtonTapSignal.asSignal(),
    retransferButtonTap: transferButton.rx.tap.asSignal(),
    signInFirebaseSignal: signInFirebaseSignal.asSignal(),
    didLimitText: authNumberTextField.rx.text.orEmpty.asDriver(),
    didLimitTime: didLimitTime.asSignal()
  )
  private lazy var output = viewModel.transform(input: input)
  private var viewModel: CertificationViewModel
  
  private let startButtonTapSignal = PublishRelay<String>()
  private let signInFirebaseSignal = PublishRelay<String>()
  private let didLimitTime = PublishRelay<Void>()
  
  private let totalTime = 60
  private lazy var currentTime = totalTime
  private lazy var totalTimeString = StopWatchConverter(totalSeconds: totalTime).simpleTimeString
  
  private var timerDisposable: Disposable?
  
  init(viewModel: CertificationViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("CertificationVC fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    setupAttributes()
    bind()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    authNumberTextField.setBorderLine()
    showToast(message: "인증번호를 보냈습니다.")
    startTimerRefresh()
  }
  
  override func bind() {
    output.showToastAction
      .emit(onNext: { [weak self] message in
        self?.showToast(message: message)
      })
      .disposed(by: disposeBag)
    
    output.isValidState
      .drive(startButton.rx.isValid)
      .disposed(by: disposeBag)
    
    output.disposeTimerAction
      .emit(onNext: { [weak self] in
        self?.timerDisposable?.dispose()
      })
      .disposed(by: disposeBag)
    
    output.indicatorAction
      .drive(onNext: {
        $0 ? IndicatorView.shared.show(backgoundColor: Asset.transparent.color) : IndicatorView.shared.hide()
      })
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(descriptionLabel)
    view.addSubview(transferButton)
    view.addSubview(authNumberTextField)
    view.addSubview(startButton)
    view.addSubview(timeLimitLabel)
  }
  
  override func setupConstraints() {
    descriptionLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(0.5)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
    transferButton.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(77)
      make.width.equalTo(72)
      make.height.equalTo(40)
      make.trailing.equalToSuperview().offset(-16)
    }
    authNumberTextField.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(77)
      make.left.equalToSuperview().offset(16)
      make.right.equalTo(transferButton.snp.left).offset(-8)
      make.height.equalTo(40)
    }
    startButton.snp.makeConstraints { make in
      make.top.equalTo(authNumberTextField.snp.bottom).offset(84)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(48)
    }
    timeLimitLabel.snp.makeConstraints { make in
      make.right.equalTo(authNumberTextField.snp.right).offset(-20)
      make.width.equalTo(37)
      make.centerY.equalTo(authNumberTextField.snp.centerY)
    }
  }
  
  private func setupAttributes() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = false
    transferButton.addTarget(self,
                             action: #selector(transferButtonTap),
                             for: .touchUpInside)
    startButton.addTarget(self,
                          action: #selector(startButtonTap),
                          for: .touchUpInside)
    timeLimitLabel.font = .title3M14
    timeLimitLabel.textColor = .green
    timeLimitLabel.text = totalTimeString
    authNumberTextField.keyboardType = .numberPad
    authNumberTextField.textContentType = .oneTimeCode
    transferButton.isValid = true
  }
  
  @objc
  private func transferButtonTap() {
    currentTime = totalTime
    timeLimitLabel.text = totalTimeString
    startTimerRefresh()
  }
  
  @objc
  private func startButtonTap() {
    if currentTime <= 0 {
      showToast(message: "시간 초과")
      return
    }
    startButtonTapSignal.accept(self.authNumberTextField.text!)
  }
  
  private func startTimerRefresh() {
    timerDisposable?.dispose()
    timerDisposable = Observable<Int>
      .interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
      .map { [unowned self] in
        self.totalTime - ($0 + 1)
      }
      .do(onNext: { [weak self] time in
        self?.currentTime = time
        if time == 0 {
          self?.didLimitTime.accept(())
        }
      })
      .filter{ $0 < 0 ? false : true }
      .map { StopWatchConverter(totalSeconds: $0).simpleTimeString }
      .bind(to: timeLimitLabel.rx.text)
  }
  
  private func showToast(message: String) {
    self.makeToastStyle()
    self.view.makeToast(message, position: .top)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  deinit {
    timerDisposable?.dispose()
  }
}
