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
    let phoneFillOutView = PhoneFillOutView()
    let phoneFillOutViewModel = PhoneFillOutViewModel()
    let disposeBag = DisposeBag()
    
    var phoneNumber: String?
    
    override func loadView() {
        super.loadView()
        self.view = phoneFillOutView
    }
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        bind()
        phoneFillOutView.phoneNumTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func bind() {
        let input = PhoneFillOutViewModel.Input(phoneNumber: phoneFillOutView.phoneNumTextFiled.rx.text, tap: phoneFillOutView.requireSmsButton.rx.tap)
        let output = phoneFillOutViewModel.transform(input: input)
        
        output.validationStatus
            .bind(onNext: { result in
                let button = self.phoneFillOutView.requireSmsButton
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let phoneNum = phoneFillOutView.phoneNumTextFiled.text ?? ""
        let result = phoneNum.starts(with: "010") ? Helper.formatNumber(with: "XXX-XXXX-XXXX", numberStr: phoneNum) : Helper.formatNumber(with: "XXX-XXX-XXXX", numberStr: phoneNum)
        textField.text = result
        phoneNumber = Helper.specifyPhoneNumber(result)
    }
    
    private func requestSMSVerification(completion: @escaping () -> ()) {
        phoneFillOutViewModel.requireSmsMessage(phoneNumber: phoneNumber!) { verificationID, error in
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
        let viewController = AuthNumFillOutViewController()
        viewController.phoneNumber = self.phoneNumber
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
