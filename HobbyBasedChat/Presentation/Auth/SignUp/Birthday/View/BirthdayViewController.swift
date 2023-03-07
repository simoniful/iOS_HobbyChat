//
//  BirthdayViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import UIKit
import RxCocoa
import RxSwift
import Toast
import SnapKit

final class BirthdayViewController: BaseViewController {
  private let descriptionLabel = BaseLabel(title: "생년월일을 알려주세요", font: .display1R20)
  private let yearPickerTextField = DatePickerTextField(placeHolder: "1990")
  private let yearLabel = BaseLabel(title: "년", font: .title2R16)
  private let monthPickerTextField = DatePickerTextField(placeHolder: "01")
  private let monthLabel = BaseLabel(title: "월", font: .title2R16)
  private let dayPickerTextField = DatePickerTextField(placeHolder: "01")
  private let dayLabel = BaseLabel(title: "일", font: .title2R16)
  private let nextButton = BaseButton(title: "다음")
  private let datePicker = UIDatePicker()
  
  private lazy var stackView = UIStackView(arrangedSubviews: [
    yearPickerTextField,
    yearLabel,
    monthPickerTextField,
    monthLabel,
    dayPickerTextField,
    dayLabel
  ])
  
  private lazy var input = BirthdayViewModel.Input(
    didSelectedDatePicker: datePicker.rx.date.asSignal(onErrorJustReturn: Date()),
    didNextButtonTap: nextButton.rx.tap
      .map({ [unowned self] in
        return (
          self.yearPickerTextField.text,
          self.monthPickerTextField.text,
          self.dayPickerTextField.text
        )
      })
      .asSignal(onErrorJustReturn: ("", "", ""))
  )
  private lazy var output = viewModel.transform(input: input)
  private let disposdBag = DisposeBag()
  
  private var viewModel: BirthdayViewModel
  
  init(viewModel: BirthdayViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("BirthViewController: fatal error")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    setupAttributes()
    bind()
  }
  
  override func bind() {
    output.showToastAction
      .emit(onNext: { [unowned self] text in
        self.view.makeToast(text, position: .top)
      })
      .disposed(by: disposdBag)
    
    output.isValid
      .drive(nextButton.rx.isValid)
      .disposed(by: disposdBag)
    
    output.yearText
      .emit(to: yearPickerTextField.rx.text)
      .disposed(by: disposdBag)
    
    output.monthText
      .emit(to: monthPickerTextField.rx.text)
      .disposed(by: disposdBag)
    
    output.dayText
      .emit(to: dayPickerTextField.rx.text)
      .disposed(by: disposdBag)
  }
  
  override func setupView() {
    view.addSubview(descriptionLabel)
    view.addSubview(stackView)
    view.addSubview(nextButton)
  }
  
  override func setupConstraints() {
    descriptionLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().multipliedBy(0.5)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
    stackView.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(60)
      make.leading.equalToSuperview().offset(30)
      make.trailing.equalToSuperview().offset(-30)
      make.height.equalTo(40)
    }
    nextButton.snp.makeConstraints { make in
      make.top.equalTo(stackView.snp.bottom).offset(60)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.height.equalTo(48)
    }
  }
  
  private func setupAttributes() {
    title = ""
    view.backgroundColor = .white
    [yearPickerTextField, monthPickerTextField, dayPickerTextField].forEach {
      let doneButton = UIBarButtonItem(title: "Done",
                                       style: .plain,
                                       target: self,
                                       action: #selector(doneDatePickerTap))
      $0.setDatePickerToolbar(datePicker: datePicker, doneButton: doneButton)
    }
    [yearLabel, monthLabel, dayLabel].forEach { label in
      label.textAlignment = .right
    }
    stackView.spacing = 0
    stackView.distribution = .equalCentering
    yearPickerTextField.becomeFirstResponder()
  }
  
  @objc
  private func doneDatePickerTap() {
    self.view.endEditing(true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
