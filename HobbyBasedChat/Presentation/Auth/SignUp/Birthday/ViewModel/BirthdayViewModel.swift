//
//  BirthdayViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

typealias BirthdayInfo = (String?, String?, String?)

final class BirthdayViewModel: ViewModel {
  
  private weak var coordinator: AuthCoordinator?
  
  struct Input {
    let didSelectedDatePicker: Signal<Date>
    let didNextButtonTap: Signal<BirthdayInfo>
  }
  struct Output {
    let isValid: Driver<Bool>
    let yearText: Signal<String>
    let monthText: Signal<String>
    let dayText: Signal<String>
    let showToastAction: Signal<String>
  }
  var disposeBag = DisposeBag()
  
  private let isValid = BehaviorRelay<Bool>(value: false)
  private let yearText = PublishRelay<String>()
  private let monthText = PublishRelay<String>()
  private let dayText = PublishRelay<String>()
  private let showToastAction = PublishRelay<String>()
  
  private var selectedDate = Date()
  
  init(coordinator: AuthCoordinator?) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    
    input.didSelectedDatePicker
      .emit(onNext: { [weak self] date in
        guard let self = self else { return }
        self.selectedDate = date
        let arr = self.dateTransform(date: date)
        self.yearText.accept(arr[0])
        self.monthText.accept(arr[1])
        self.dayText.accept(arr[2])
        self.isValid.accept(true)
      })
      .disposed(by: disposeBag)
    
    input.didNextButtonTap
      .map(validationDate)
      .emit(onNext: { [weak self] isValidBirth in
        guard let self = self else { return }
        if isValidBirth {
          self.saveBirthInfo()
          self.coordinator?.showEmailViewController()
        }
      })
      .disposed(by: disposeBag)
    
    return Output(
      isValid: isValid.asDriver(),
      yearText: yearText.asSignal(),
      monthText: monthText.asSignal(),
      dayText: dayText.asSignal(),
      showToastAction: showToastAction.asSignal()
    )
  }
}

extension BirthdayViewModel {
  private func saveBirthInfo() {
    UserDefaults.standard.set(self.selectedDate, forKey: UserDefaultKey.birth)
  }
  
  private func dateTransform(date: Date) -> [String] {
    let dateString = dateToString(date: date)
    let arr = dateString.components(separatedBy: " ")
    return arr
  }
  
  private func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko-KR")
    dateFormatter.dateFormat = "yyyy MM dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
  
  private func validationDate(year: String?, month: String?, day: String?) -> Bool {
    guard let year = year, year != "", let month = month, let day = day else {
      self.showToastAction.accept(ToastCase.emptyDate.description)
      return false
    }
    guard Int(year) != nil, Int(month) != nil, Int(day) != nil else {
      self.showToastAction.accept(ToastCase.inValidDate.description)
      return false
    }
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko-KR")
    guard let add17YearsDate = calendar.date(byAdding: .year, value: 17, to: selectedDate) else {
      self.showToastAction.accept(ToastCase.inValidDate.description)
      return false
    }
    if Date() < add17YearsDate {
      self.showToastAction.accept(ToastCase.limitEge.description)
      return false
    }
    return true
  }
}

