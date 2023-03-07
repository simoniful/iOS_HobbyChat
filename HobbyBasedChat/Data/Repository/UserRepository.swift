//
//  UserRepository.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation
import RxSwift

final class UserRepository: UserRepositoryInterface {
    func fetchFCMToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.fcmToken)
    }

    func fetchPhoneNumber() -> String? {
        UserDefaults.standard.string(forKey: UserDefaultKey.phoneNumber)
    }

    func fetchIDToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.idToken)
    }

    func fetchNickName() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.nickName)
    }

    func fetchBirth() -> Date? {
        return UserDefaults.standard.object(forKey: UserDefaultKey.birth) as? Date
    }

    func fetchEmail() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.email)
    }

    func fetchGender() -> GenderCase? {
        let value = UserDefaults.standard.integer(forKey: UserDefaultKey.gender)
        return GenderCase(value: value)
    }

    func fetchMatchStatus() -> MatchStatus? {
        let value = UserDefaults.standard.string(forKey: UserDefaultKey.matchStatus) ?? ""
        return MatchStatus(value: value)
    }

    func fetchMatchedUserIDInfo() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.matchesUserID)
    }

    func fetchMyIDInfo() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.myID)
    }

    func saveMyIDInfo(id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultKey.myID)
    }

    func saveMatchedUserIDInfo(id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultKey.matchesUserID)
    }

    func savePhoneNumberInfo(phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: UserDefaultKey.phoneNumber)
    }

    func saveIdTokenInfo(idToken: String) {
        UserDefaults.standard.set(idToken, forKey: UserDefaultKey.idToken)
    }

    func saveGenderInfo(gender: GenderCase) {
        let genderValue = gender.value
        UserDefaults.standard.set(genderValue, forKey: UserDefaultKey.gender)
    }

    func saveLogInInfo() {
        UserDefaults.standard.set(true, forKey: UserDefaultKey.isLoggedIn)
    }

    func saveBirthInfo(birth: Date) {
        UserDefaults.standard.set(birth, forKey: UserDefaultKey.birth)
    }

    func saveEmailInfo(email: String) {
        UserDefaults.standard.set(email, forKey: UserDefaultKey.email)
    }

    func saveNicknameInfo(nickname: String) {
        UserDefaults.standard.set(nickname, forKey: UserDefaultKey.nickName)
    }

    func saveMatchStatus(status: MatchStatus) {
        UserDefaults.standard.set(status.rawValue, forKey: UserDefaultKey.matchStatus)
    }

    func logoutUserInfo() {
        UserDefaults.standard.set(false, forKey: UserDefaultKey.isLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.idToken)
    }

    func withdrawUserInfo() {
        UserDefaults.standard.setValue(false, forKey: UserDefaultKey.isLoggedIn)
        UserDefaults.standard.setValue(false, forKey: UserDefaultKey.isNotFirstUser)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.matchStatus)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.gender)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.phoneNumber)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.email)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.birth)
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.idToken)
    }

    func deleteFCMToken() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.fcmToken)
    }

    func deleteMatchedUserIDInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.matchesUserID)
    }
}
