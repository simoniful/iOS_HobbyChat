//
//  GenderViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/19.
//

import Foundation
import RxCocoa
import RxSwift

enum TapBtn {
    case man
    case woman
}

class GenderViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let maleButtonTap: ControlEvent<Void>
        let femaleButtonTap: ControlEvent<Void>
        let nextButtonTap: ControlEvent<Void>
    }

    struct Output {
        let maleButtonStatus: Observable<Bool>
        let femaleButtonStatus: Observable<Bool>
        let validateStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        var savedMaleStatus = false
        var savedFemaleStatus = false
        
        if let genderCode = UserDefaults.standard.string(forKey: "newbieGender") {
            switch genderCode {
            case "male":
                savedMaleStatus = true
                savedFemaleStatus = false
            case "female":
                savedMaleStatus = false
                savedFemaleStatus = true
            default:
                savedMaleStatus = false
                savedFemaleStatus = false
            }
        }
        
        let changeMaleStatus = input.maleButtonTap
            .scan (false) { (old, new) in
                !old
            }
            .share(replay: 1, scope: .whileConnected)
            
        let changeFemaleStatus = input.femaleButtonTap
            .scan (false) { old, new in
                !old
            }
            .share(replay: 1, scope: .whileConnected)
            
        let combineStatus = Observable.combineLatest(
            changeMaleStatus.startWith(savedMaleStatus),
            changeFemaleStatus.startWith(savedFemaleStatus)
        ){
            a, b -> Bool in
            print(a, b)
            let status = a || b
            
            return status
        }
        .share(replay: 1, scope: .whileConnected)
        
        return Output(maleButtonStatus: changeMaleStatus, femaleButtonStatus: changeFemaleStatus, validateStatus: combineStatus, sceneTransition: input.nextButtonTap)
    }
    
    func requestSignUp(_ completion: @escaping (Int?, Error?) -> ()) {
        guard let idToken = UserDefaults.standard.string(forKey: "FirebaseIdToken") else { return }
        let request = SignUp(phoneNumber: "", FCMtoken: "", nick: "", birth: "", email: "", gender: 0).fromUserDefaultValue
        
        UserAPI.requestSignUp(idToken: idToken, request: request) { statusCode, error in
            switch statusCode {
            case 200:
                UserDefaults.standard.set(true, forKey: "isSingUpCompleted")
                completion(statusCode, error)
            case 401:
                FireBaseService.requestIDToken { idToken, error in
                    if let error = error {
                        print("ID 토큰 갱신 오류, 잠시 후 다시 시도", error.localizedDescription)
                    }
                    if let idToken = idToken {
                        UserAPI.requestSignUp(idToken: idToken, request: request) { statusCode, error in
                            completion(statusCode, error)
                        }
                    }
                }
            default:
                print(statusCode!)
                completion(statusCode, error)
            }
        }
        
    }
}
