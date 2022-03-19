//
//  AuthNumberFillOutViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//


import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Toast


class AuthNumberViewController: UIViewController {
    let authNumberView = AuthNumberView()
    let authNumberViewModel = AuthNumberViewModel()
    let disposeBag = DisposeBag()
    
    var timer: Timer?
    var secLeft: Int = 60
    var phoneNumber: String?
    
    override func loadView() {
        super.loadView()
        self.view = authNumberView
    }
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        updateTimerLabel()
        startTimer()
        bind()
        authNumberView.authNumTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.makeToast("인증번호를 보냈습니다")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let authNum = authNumberView.authNumTextFiled.text ?? ""
        let result = Helper.formatNumber(with: "XXXXXX", numberStr: authNum)
        textField.text = result
    }
    
    func bind() {
        let input = AuthNumberViewModel.Input(authNumber: authNumberView.authNumTextFiled.rx.text, retryButtonTap: authNumberView.retryButton.rx.tap, authAndStartButtonTap: authNumberView.authAndStartButton.rx.tap)
        let output = authNumberViewModel.transform(input: input)
        
        output.validationStatus
            .bind(onNext: { result in
                let button = self.authNumberView.authAndStartButton
                button.isEnabled = result
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
        
        output.timerReset
            .subscribe { _ in
                self.view.makeToast("전화 번호 인증 시작")
                self.requestSMSVerification {
                    self.secLeft = 60
                    self.timer?.invalidate()
                    self.timer = nil
                    self.startTimer()
                }
            }
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.authAndStartButtonClicked()
            }
            .disposed(by: disposeBag)
    }
    
    func updateTimerLabel() {
        let minutes = self.secLeft / 60
        let seconds = self.secLeft % 60
        
        if self.secLeft < 10 {
            self.authNumberView.timerLabel.textColor = R.color.systemcolor_error()
        } else {
            self.authNumberView.timerLabel.textColor = R.color.brandcolor_green()
        }
        
        UIView.transition(with: self.authNumberView.timerLabel, duration: 0.3, options: .curveEaseInOut) {
            if self.secLeft > 0 {
               self.authNumberView.timerLabel.text = String(format: "%02d:%02d", minutes, seconds )
            } else {
                self.authNumberView.timerLabel.text = "유효시간 만료"
            }
        }
    }
    
    func startTimer() {
        self.updateTimerLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {t in
            if self.secLeft != 0 {
                self.secLeft -= 1
                self.updateTimerLabel()
            } else {
                self.view.makeToast("전화번호 인증 실패")
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
    
    private func requestSMSVerification(completion: @escaping () -> ()) {
        authNumberViewModel.requestSmsMessage(phoneNumber: phoneNumber!) { verificationID, error in
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
    
    @objc func authAndStartButtonClicked() {
        guard let currentVerificationId = UserDefaults.standard.string(forKey: "authVerificationID") else {
            self.view.makeToast("전화번호 인증 실패")
            return
        }
        guard let verificationCode = self.authNumberView.authNumTextFiled.text else {
            self.view.makeToast("인증 번호를 입력하세요")
            return }
        
        authNumberViewModel.requestSmsAuth(verificationID: currentVerificationId, verificationCode: verificationCode) { _, error in
            if error != nil {
                var style = ToastStyle()
                style.messageAlignment = .center
                self.view.makeToast("에러가 발생했습니다\n잠시 후 다시 시도해주세요", style: style)
                return
            }
            
            self.authNumberViewModel.requestUserInfo { user, error, statusCode in
                switch statusCode {
                case 200:
                    print("\(statusCode ?? 0) 성공")
                    self.view.makeToast("이미 가입된 회원입니다.")
//                    Helper.transitionToRootView(view: self.view, controller: MainTabBarController())

                case 406:
                    print("\(statusCode ?? 0) 미가입 유저")
                    self.view.makeToast("휴대폰 번호 인증에 성공했습니다.")
                    Helper.transitionToNavRootView(view: self.view, controller: NicknameViewController())
                    
                case 401:
                    print("\(statusCode ?? 0) Firebase Token Error")
                    var style = ToastStyle()
                    style.messageAlignment = .center
                    self.view.makeToast("에러가 발생했습니다.\n잠시 후 다시 시도해주세요.", style: style)
                    return
                    
                default:
                    print("Error Code:", statusCode ?? 0)
                }
            }
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}
