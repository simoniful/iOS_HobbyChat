//
//  PhoneFillOutModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth
import Alamofire

class PhoneNumberViewModel: CommonViewModel {
    var disposeBag: DisposeBag =  DisposeBag()
    
    struct Input {
        let phoneNumber: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let convertedPhoneNumber: Observable<String>
        let validationStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let convertedPhoneNumber = input.phoneNumber
            .orEmpty
            .map {
                $0.starts(with: "010") ? Helper.formatNumber(with: "XXX-XXXX-XXXX", numberStr: $0) : Helper.formatNumber(with: "XXX-XXX-XXXX", numberStr: $0)
            }
            .share(replay: 1, scope: .whileConnected)
        
        let validationStatus = input.phoneNumber
            .orEmpty
            .map { self.isValidPhoneNum(testStr: $0) }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(convertedPhoneNumber: convertedPhoneNumber, validationStatus: validationStatus, sceneTransition: input.tap)
    }
    
    func isValidPhoneNum(testStr:String) -> Bool {
          let phoneNumRegEx = "[0-9]{3}[-]+[0-9]{3,4}[-]+[0-9]{4}"
          let phoneNumTest = NSPredicate(format:"SELF MATCHES %@", phoneNumRegEx)
          return phoneNumTest.evaluate(with: testStr)
    }
    
    func requireSmsMessage(phoneNumber: String, completion: @escaping (String?, Error?) -> ()) {
        Auth.auth().languageCode = "ko"
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard let error = error else {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                completion(verificationID, nil)
                return
            }
            completion(nil, error)
        }
    }
}
