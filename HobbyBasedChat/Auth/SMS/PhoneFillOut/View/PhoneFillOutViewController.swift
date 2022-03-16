//
//  PhoneFillOutViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import UIKit
import Rswift
import RxSwift
import RxCocoa
import FirebaseAuth
import Toast

class PhoneFillOutViewController: UIViewController {
    let phoneNumberView = PhoneNumberView()
    let phoneNumberViewModel = PhoneNumberViewModel()
    let disposeBag = DisposeBag()
    
    var phoneNumber: String?
    
    override func loadView() {
        super.loadView()
        self.view = phoneNumberView
    }
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkMoniter()
    }

    func bind() {
        let input = PhoneNumberViewModel.Input(phoneNumber: phoneNumberView.phoneNumTextFiled.rx.text, tap: phoneNumberView.requireSmsButton.rx.tap)
        let output = phoneNumberViewModel.transform(input: input)
        
        output.convertedPhoneNumber
            .bind { result in
                self.phoneNumberView.phoneNumTextFiled.text = result
                self.phoneNumber = Helper.specifyPhoneNumber(result)
            }
            .disposed(by: disposeBag)
        
        output.validationStatus
            .bind(onNext: { result in
                let button = self.phoneNumberView.requireSmsButton
                button.isEnabled = result
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.requestSMSVerification {
                    self.pushAuthNumFillout()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func requestSMSVerification(completion: @escaping () -> ()) {
        phoneNumberViewModel.requireSmsMessage(phoneNumber: phoneNumber!) { verificationID, error in
            if error == nil {
                completion()
            } else {
                if error?.localizedDescription == "Invalid format." {
                    var style = ToastStyle()
                    style.messageAlignment = .center
                    self.view.makeToast("유효하지 않은 전화번호 형식입니다.", style: style)
                } else {
                    var style = ToastStyle()
                    style.messageAlignment = .center
                    self.view.makeToast("에러가 발생했습니다.\n다시 시도해주세요", style: style)
                }
            }
        }
    }
    
    func pushAuthNumFillout() {
        let viewController = AuthNumberViewController()
        viewController.phoneNumber = self.phoneNumber
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
