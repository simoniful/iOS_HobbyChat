//
//  NicknameViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth
import Alamofire

class NicknameViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let nickname: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let validationStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.nickname
            .orEmpty
            .map { self.isValidNickname(testStr: $0) }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validationStatus: result, sceneTransition: input.tap)
    }
    
    func isValidNickname(testStr:String) -> Bool {
          let nicknameRegEx = "[가-힣A-Za-z0-9]{1,10}"
          let nicknameTest = NSPredicate(format:"SELF MATCHES %@", nicknameRegEx)
          return nicknameTest.evaluate(with: testStr)
    }
}
