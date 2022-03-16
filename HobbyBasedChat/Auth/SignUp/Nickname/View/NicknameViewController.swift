//
//  NicknameViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class NicknameViewController: UIViewController {
    let nicknameView = NicknameView()
    let nicknameViewModel = NicknameViewModel()
    let disposeBag = DisposeBag()
    
    var btnActionHandler: (() -> ())?
    var isValidated: Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "newbieNickname") != nil {
            nicknameView.nicknameTextFiled.text = UserDefaults.standard.string(forKey: "newbieNickname")
        }
        nicknameView.nicknameTextFiled.becomeFirstResponder()
        if let btnActionHandler = btnActionHandler {
            btnActionHandler()
        }
        bind()
    }
    
    func bind() {
        let input = NicknameViewModel.Input(nickname: nicknameView.nicknameTextFiled.rx.text, tap: nicknameView.nextStepButton.rx.tap)
        let output = nicknameViewModel.transform(input: input)
        
        output.validationStatus
            .bind(onNext: { result in
                self.isValidated = result
                let button = self.nicknameView.nextStepButton
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                if self.isValidated {
                    guard let nickname = self.nicknameView.nicknameTextFiled.text else { return }
                    UserDefaults.standard.set(nickname, forKey: "newbieNickname")
                    self.navigationController?.pushViewController(BirthdayViewController(), animated: true)
                } else {
                    self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요")
                }
            }
            .disposed(by: disposeBag)
    }
}
