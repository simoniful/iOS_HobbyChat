//
//  EmailViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/17.
//

import Foundation
import RxSwift
import RxCocoa

class EmailViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let email: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let validationStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.email
            .orEmpty
            .map { self.isValidEmail(testStr: $0) }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validationStatus: result, sceneTransition: input.tap)
    }
    
    func isValidEmail(testStr:String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: testStr)
    }
}
