//
//  CommonViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import Foundation
import RxSwift

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
    var disposeBag: DisposeBag { get set }
}
