//
//  GenderViewController.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/19.
//
import UIKit
import FirebaseAuth
import Alamofire
import RxSwift
import RxCocoa
import Toast

class GenderViewController: UIViewController {
    let genderView = GenderView()
    let genderViewModel = GenderViewModel()
    let disposeBag = DisposeBag()

    var isValidated = false
    
    override func loadView() {
        super.loadView()
        self.view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let genderCode = UserDefaults.standard.string(forKey: "newbieGender")
        switch genderCode {
        case "male":
            genderView.maleButton.isSelected = true
            genderView.femaleButton.isSelected = false
        case "female":
            genderView.maleButton.isSelected = false
            genderView.femaleButton.isSelected = true
        default:
            genderView.maleButton.isSelected = false
            genderView.femaleButton.isSelected = false
        }
        bind()
    }
    
    func bind() {
        let input = GenderViewModel.Input(maleButtonTap: genderView.maleButton.rx.tap, femaleButtonTap: genderView.femaleButton.rx.tap, nextButtonTap: genderView.nextStepButton.rx.tap)
        
        let output = genderViewModel.transform(input: input)
        
        output.maleButtonStatus
            .bind(to: genderView.maleButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.femaleButtonStatus
            .bind(to: genderView.femaleButton.rx.isSelected)
            .disposed(by: disposeBag)
    
        output.validateStatus
            .bind(onNext: { result in
                self.isValidated = result
                let button = self.genderView.nextStepButton
                var configuration = button.configuration
                configuration?.baseForegroundColor = result ? R.color.custom_white() : R.color.grayscale_gray6()
                configuration?.baseBackgroundColor = result ? R.color.brandcolor_green() : R.color.grayscale_gray3()
                button.configuration = configuration
            })
            .disposed(by: disposeBag)
            
        output.sceneTransition
            .subscribe { _ in
                self.nextbuttonClicked()
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextbuttonClicked() {
        let genderCode: GenderState = calculateGenderCode()
        UserDefaults.standard.set(genderCode.rawValue, forKey: "newbieGender")
        genderViewModel.requestSignUp { statusCode, error in
            switch statusCode {
//            case 200:
//                self.view.makeToast("회원가입에 성공했습니다.")
//                Helper.transitionToRootView(view: self.view, controller: MainTabBarController())
//            case 201:
//                self.view.makeToast("이미 가입한 유저입니다.")
//                Helper.transitionToRootView(view: self.view, controller: MainTabBarController())
            case 202:
                var style = ToastStyle()
                style.messageAlignment = .center
                self.view.makeToast("사용할 수 없는 닉네임입니다.\n닉네임 설정 화면으로 이동합니다.", style: style)
                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                    if let nickVC = viewController as? NicknameViewController { self.navigationController?.popToViewController(nickVC, animated: true)
                    }
                }
            default:
                print(statusCode!)
            }
        }
    }
    
    func calculateGenderCode() -> GenderState {
        var genderCode: GenderState = .unselected
        let isMaleSelected = genderView.maleButton.isSelected
        let isFemaleSelected = genderView.femaleButton.isSelected
        
        if isMaleSelected && isFemaleSelected {
            genderCode = .unselected
        } else if isMaleSelected {
            genderCode = .male
        } else if isFemaleSelected {
            genderCode = .female
        }
        return genderCode
    }
}
