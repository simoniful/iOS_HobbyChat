//
//  SignUp.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/19.
//

import Foundation

struct SignUp: Codable {
    let phoneNumber: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let email: String
    let gender: Int
}

extension SignUp {
    var fromUserDefaultValue: SignUp {
        let FCMtoken = UserDefaults.standard.string(forKey: "FCMToken") ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: "newbiePhoneNumber") ?? ""
        let nick = UserDefaults.standard.string(forKey: "newbieNickname") ?? ""
        let birth = UserDefaults.standard.object(forKey: "newbieBirthDay") as? Date ?? Date()
        let email = UserDefaults.standard.string(forKey: "newbieEmail") ?? ""
        let gender = UserDefaults.standard.string(forKey: "newbieGender") ?? ""
        
        let birthStr = birth.customDateToString()
        let genderCode: Int
        switch gender {
        case "male":
            genderCode = 1
        case "female":
            genderCode = 0
        default:
            genderCode = -1
        }
        
        return SignUp(
            phoneNumber: phoneNumber,
            FCMtoken: FCMtoken,
            nick: nick,
            birth: birthStr,
            email: email,
            gender: genderCode
        )
    }
}

enum GenderState: String {
    case unselected
    case male
    case female
}
