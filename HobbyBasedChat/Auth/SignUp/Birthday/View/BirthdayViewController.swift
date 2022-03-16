//
//  BirthdayViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import UIKit
import Rswift
import RxCocoa
import RxSwift

class BirthdayViewController: UIViewController {
    let birthdayView = BirthdayView()
    let birthdayViewModel = BirthdayViewModel()
    let disposeBag = DisposeBag()
    var isValidated: Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = birthdayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let date = UserDefaults.standard.object(forKey: "newbieBirthDay") as? Date {
            birthdayView.datePicker.date = date
        }
        bind()
        birthdayView.yearTextFiled.becomeFirstResponder()
        birthdayView.yearTextFiled.inputView = birthdayView.datePicker
        birthdayView.monthTextFiled.inputView = birthdayView.datePicker
        birthdayView.dayTextFiled.inputView = birthdayView.datePicker
    }
    
    func bind() {
        let input = BirthdayViewModel.Input(date: birthdayView.datePicker.rx.date, tap: birthdayView.nextStepButton.rx.tap)
        let output = birthdayViewModel.transform(input: input)
        
        output.validationStatus
            .bind(onNext: { result in
                self.isValidated = result
                let button = self.birthdayView.nextStepButton
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
        
        output.yearStr
            .bind(to: birthdayView.yearTextFiled.rx.text)
            .disposed(by: disposeBag)
        
        output.monthStr
            .bind(to: birthdayView.monthTextFiled.rx.text)
            .disposed(by: disposeBag)
        
        output.dayStr
            .bind(to: birthdayView.dayTextFiled.rx.text)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                if self.isValidated {
                    let date = self.birthdayView.datePicker.date
                    UserDefaults.standard.set(date, forKey: "newbieBirthDay")
                    self.navigationController?.pushViewController(EmailViewController(), animated: true)
                } else {
                    self.view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다")
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
