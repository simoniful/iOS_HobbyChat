//
//  BirthdayViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import RxSwift
import RxCocoa

class BirthdayViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let date: ControlProperty<Date>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let validationStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
        let yearStr: Observable<String>
        let monthStr: Observable<String>
        let dayStr: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let status = input.date
            .map { $0.age >= 17 }
            .share(replay: 1, scope: .whileConnected)
        
        let yearStr = input.date
            .map { (date: Date) -> String in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year], from: date)
                if let year = components.year {
                    let yearString = String(year)
                    return yearString
                } else {
                    return ""
                }
            }
            .share(replay: 1, scope: .whileConnected)
        
        let monthStr = input.date
            .map { (date: Date) -> String in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.month], from: date)
                if let month = components.month {
                    let monthString = String(month)
                    return monthString
                } else {
                    return ""
                }
            }
            .share(replay: 1, scope: .whileConnected)
        
        let dayStr = input.date
            .map { (date: Date) -> String in
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: date)
                if let day = components.day {
                    let dayString = String(day)
                    return dayString
                } else {
                    return ""
                }
            }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validationStatus: status, sceneTransition: input.tap, yearStr: yearStr, monthStr: monthStr, dayStr: dayStr)
    }
}
