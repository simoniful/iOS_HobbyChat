//
//  EmailViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/17.
//

import UIKit
import RxCocoa
import RxSwift

class EmailViewController: UIViewController {
    let emailView = EmailView()
    let emailViewModel = EmailViewModel()
    let disposeBag = DisposeBag()
    
    var isValidated = false
    
    override func loadView() {
        super.loadView()
        self.view = emailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = UserDefaults.standard.string(forKey: "newbieEmail") {
            emailView.emailTextFiled.text = email
        }
        emailView.emailTextFiled.becomeFirstResponder()
        bind()
    }
    
    func bind() {
        let input = EmailViewModel.Input(email: emailView.emailTextFiled.rx.text, tap: emailView.nextStepButton.rx.tap)
        
        let output = emailViewModel.transform(input: input)
        
        output.validationStatus
            .bind(onNext: { result in
                self.isValidated = result
                let button = self.emailView.nextStepButton
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                if self.isValidated {
                    guard let email = self.emailView.emailTextFiled.text else { return }
                    UserDefaults.standard.set(email, forKey: "newbieEmail")
                    self.navigationController?.pushViewController(GenderViewController(), animated: true)
                } else {
                    self.view.makeToast("이메일 형식이 올바르지 않습니다")
                }
            }
            .disposed(by: disposeBag)
    }
}
