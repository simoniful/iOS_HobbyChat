//
//  AuthNumberFillOutViewModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import FirebaseAuth

class AuthNumberViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let authNumber: ControlProperty<String?>
        let retryButtonTap: ControlEvent<Void>
        let authAndStartButtonTap: ControlEvent<Void>
    }

    struct Output {
        let validationStatus: Observable<Bool>
        let timerReset: ControlEvent<Void>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.authNumber
            .orEmpty
            .map { self.isValidAuthNum(testStr: $0) }
            .share(replay: 1, scope: .whileConnected)
        return Output(validationStatus: result, timerReset: input.retryButtonTap, sceneTransition: input.authAndStartButtonTap)
    }
    
    func isValidAuthNum(testStr:String) -> Bool {
          let authNumRegEx = "[0-9]{6}"
          let authNumTest = NSPredicate(format:"SELF MATCHES %@", authNumRegEx)
          return authNumTest.evaluate(with: testStr)
    }
    
    func requestSmsMessage(phoneNumber: String, completion: @escaping (String?, Error?) -> ()) {
        Auth.auth().languageCode = "ko"
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                guard let error = error else {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    UserDefaults.standard.set(phoneNumber, forKey: "newbiePhoneNumber")
                    completion(verificationID, nil)
                    return
                }
                completion(nil, error)
            }
    }
    
    func requestSmsAuth(verificationID: String?, verificationCode: String?, completion: @escaping (AuthDataResult?, Error?) -> ()) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "",
            verificationCode: verificationCode ?? ""
        )
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                FirebaseService.requestIDToken { idToken, error in
                    if let error = error {
                        print("ID 토큰 갱신 오류, 잠시 후 다시 시도", error.localizedDescription)
                        completion(nil ,error)
                    }
                    completion(success, nil)
                }
            } else {
                completion(nil, error)
                print("getVerificationCode Error: ",error.debugDescription)
            }
        }
    }
    
    func requestUserInfo(completion: @escaping (User?, Error?, Int?) -> ()) {
        let idToken = UserDefaults.standard.string(forKey: "FirebaseIdToken") ?? ""
        
        UserAPI.requestUserInfo(idToken: idToken) { user, error, statusCode in
            switch statusCode {
            case 200:
                UserDefaults.standard.set(true, forKey: "isSingUpCompleted")
            case 406:
                UserDefaults.standard.set(true, forKey: "isSMSAuthCompleted")
            case 401:
                FirebaseService.requestIDToken { idToken, error in
                    if let error = error {
                        print("ID 토큰 갱신 오류, 잠시 후 다시 시도", error.localizedDescription)
                    }
                    if let idToken = idToken {
                        UserAPI.requestUserInfo(idToken: idToken) { user, error, statusCode in
                            completion(user, error, statusCode)
                        }
                    }
                }
            default:
                print("AuthNumFillOutViewModel - requestUserInfo", statusCode!)
            }
            completion(user, error, statusCode)
        }
    }
}
