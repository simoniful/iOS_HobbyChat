//
//  UserRepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

protocol UserRepositoryInterface: AnyObject {
  func fetchFCMToken() -> String?
  
  func fetchPhoneNumber() -> String?
  
  func fetchIDToken() -> String?
  
  func fetchNickName() -> String?
  
  func fetchBirth() -> Date?
  
  func fetchEmail() -> String?
  
  func fetchGender() -> GenderCase?
  
  func fetchMatchStatus() -> MatchStatus?
  
  func fetchMatchedUserIDInfo() -> String?
  
  func fetchMyIDInfo() -> String?
  
  func saveMyIDInfo(id: String)
  
  func saveMatchedUserIDInfo(id: String)
  
  func savePhoneNumberInfo(phoneNumber: String)
  
  func saveGenderInfo(gender: GenderCase)
  
  func saveLogInInfo()
  
  func saveNicknameInfo(nickname: String)
  
  func saveEmailInfo(email: String)
  
  func saveBirthInfo(birth: Date)
  
  func saveMatchStatus(status: MatchStatus)
  
  func logoutUserInfo()
  
  func saveIdTokenInfo(idToken: String)
  
  func withdrawUserInfo()
  
  func deleteFCMToken()
  
  func deleteMatchedUserIDInfo()
}
