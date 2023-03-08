//
//  NicknameViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

final class NicknameViewController: BaseViewController {
  private let descriptionLabel = BaseLabel(title: "닉네임을 입력해 주세요", font: .display1R20)
  private let nicknameTextField = BaseTextField(placeHolder: "10자 이내로 입력")
  private let nextButton = BaseButton(title: "다음")
  
  private lazy var input = NicknameViewModel.Input(
    didTextChange: nicknameTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
    didNextButtonTap: nextButton.rx.tap
      .map { [unowned self] in
        return self.nicknameTextField.text!
      }
      .asSignal(onErrorJustReturn: "")
  )
  private lazy var output = viewModel.transform(input: input)
  private let didTextChange = PublishRelay<String>()
  private let didNextButtonTap = PublishRelay<String>()
  private var viewModel: NicknameViewModel
  
  init(viewModel: NicknameViewModel) {
    self.viewModel = viewModel
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
    bind()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nicknameTextField.setBorderLine()
  }
  
  override func bind() {
    output.showToastAction
      .emit(onNext: { [unowned self] text in
        self.view.makeToast(text, position: .top)
      })
      .disposed(by: disposeBag)
    
    output.isValidState
      .drive(nextButton.rx.isValid)
      .disposed(by: disposeBag)
  }
  
  override func setupView() {
    view.addSubview(descriptionLabel)
    view.addSubview(nicknameTextField)
    view.addSubview(nextButton)
  }
  
  override func setupConstraints() {
    descriptionLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(0.5)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
    nicknameTextField.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(60)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(40)
    }
    nextButton.snp.makeConstraints { make in
      make.top.equalTo(nicknameTextField.snp.bottom).offset(60)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(48)
    }
  }
  
  private func setupAttributes() {
    title = ""
    view.backgroundColor = .white
    nicknameTextField.becomeFirstResponder()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
