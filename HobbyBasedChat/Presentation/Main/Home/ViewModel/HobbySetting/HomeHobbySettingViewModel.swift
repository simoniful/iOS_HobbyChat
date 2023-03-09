//
//  HomeHobbySettingViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeHobbySettingViewModel: ViewModel {
  private weak var coordinator: HomeCoordinator?
  private let useCase: HomeHobbySettingUseCase
  private let userCoordinate: Coordinate
  
  struct Input {
    let viewWillAppearSignal: Signal<Void>
    let searhBarTapWithText: Signal<String>
    let itemSelectedSignal: Signal<HobbySettingItem>
    let sesacSearchButtonTap: Signal<Void>
  }
  struct Output {
    let hobbyItems: Driver<[HomeHobbySettingSectionModel]>
    let removeSearchBarTextAction: Signal<Void>
    let showToastAction: Signal<String>
    let indicatorAction: Driver<Bool>
  }
  var disposeBag = DisposeBag()
  
  private let hobbyItems = BehaviorRelay<[HomeHobbySettingSectionModel]>(value: [])
  private let removeSearchBarTextAction = PublishRelay<Void>()
  private let showToastAction = PublishRelay<String>()
  private let indicatorAction = BehaviorRelay<Bool>(value: false)
  
  init(
    coordinator: HomeCoordinator?,
    useCase: HomeHobbySettingUseCase,
    coordinate: Coordinate
  ) {
    self.coordinator = coordinator
    self.useCase = useCase
    self.userCoordinate = coordinate
  }
  
  func transform(input: Input) -> Output {
    input.viewWillAppearSignal
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        self.indicatorAction.accept(true)
        self.requestOnqueue(coordinate: self.userCoordinate)
      })
      .disposed(by: disposeBag)
    
    input.searhBarTapWithText
      .do { [weak self] _ in
        self?.removeSearchBarTextAction.accept(())
      }
      .map(validationSearchText)
      .emit(onNext: { [weak self] isvalid, text in
        guard let self = self else { return }
        if isvalid {
          let selectedItem = HobbySettingItem.selected(Hobby(content: text))
          self.addSelectedItem(selectedItem: selectedItem)
        } else {
          self.showToastAction.accept(ToastCase.inValidSelectedHobbyTextCount.description)
        }
      })
      .disposed(by: disposeBag)
    
    input.itemSelectedSignal
      .emit(onNext: { [weak self] item in
        guard let self = self else { return }
        switch item {
        case .near(let hobby):
          let selectedItem = HobbySettingItem.selected(hobby)
          self.addSelectedItem(selectedItem: selectedItem)
        case .selected(_):
          var items = self.hobbyItems.value
          if let index = items[1].items.firstIndex(of: item) {
            items[1].items.remove(at: index)
          }
          self.hobbyItems.accept(items)
          return
        }
      })
      .disposed(by: disposeBag)
    
    input.sesacSearchButtonTap
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        let items = self.mySelectedItems()
        let hobbys = items.isEmpty ? ["Anything"] : items.map { $0.content }
        self.requestSearchSesac(coordinate: self.userCoordinate, hobbys: hobbys)
      })
      .disposed(by: disposeBag)
    
    useCase.successOnqueueSignal
      .asSignal()
      .emit(onNext: { [weak self] onqueue in
        guard let self = self else { return }
        let queue = self.makeHomeSearchItemViewModel(onqueue: onqueue)
        let section = queue.map { HobbySettingItem.near($0) }
        let sections = [
          HomeHobbySettingSectionModel(model: .near, items: section),
          HomeHobbySettingSectionModel(model: .selected, items: [])
        ]
        self.hobbyItems.accept(sections)
      })
      .disposed(by: disposeBag)
    
    useCase.successSearchSesac
      .asSignal()
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        self.coordinator?.showHobbySearchViewController(coordinate: self.userCoordinate)
      })
      .disposed(by: disposeBag)
    
    Observable.merge(
      useCase.successOnqueueSignal.map { _ in () },
      useCase.unKnownErrorSignal.asObservable()
    )
    .asDriver(onErrorJustReturn: ())
    .map { _ in false }
    .drive(indicatorAction)
    .disposed(by: disposeBag)
    
    return Output(
      hobbyItems: hobbyItems.asDriver(),
      removeSearchBarTextAction: removeSearchBarTextAction.asSignal(),
      showToastAction: showToastAction.asSignal(),
      indicatorAction: indicatorAction.asDriver()
    )
  }
}


extension HomeHobbySettingViewModel {
    private func validationSearchText(text: String) -> (Bool, String) {
        return (text.count <= 8, text)
    }

    private func addSelectedItem(selectedItem: HobbySettingItem) {
        var items = self.hobbyItems.value
        if items[1].items.count >= 8 {
            self.showToastAction.accept(ToastCase.limitSelectedHobbyCount.description)
        } else if items[1].items.contains(selectedItem) {
            self.showToastAction.accept(ToastCase.duplicatedSelectedHobby.description)
        } else {
            items[1].items.append(selectedItem)
            self.hobbyItems.accept(items)
        }
    }

    private func mySelectedItems() -> [Hobby] {
        return self.hobbyItems.value[1].items.map { $0.hobby }
    }

    private func makeHomeSearchItemViewModel(onqueue: Onqueue) -> [Hobby] {
        var queue = [Hobby]()
        onqueue.fromRecommend.forEach { queue.append(Hobby(content: $0, isRecommended: true)) }
        onqueue.fromSesacDB.forEach { sesac in
            queue += sesac.hobbys.map { Hobby(content: $0) }
        }
        onqueue.fromSesacDBRequested.forEach { sesac in
            queue += sesac.hobbys.map { Hobby(content: $0) }
        }
        return queue
    }

    private func requestOnqueue(coordinate: Coordinate) {
        self.useCase.requestOnqueue(coordinate: coordinate)
    }

    private func requestSearchSesac(coordinate: Coordinate, hobbys: [String]) {
        self.useCase.requestSearchSesac(coordinate: coordinate, hobbys: hobbys)
    }
}

