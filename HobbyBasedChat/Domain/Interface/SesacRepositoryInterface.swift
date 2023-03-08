//
//  SesacRepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation
import Moya

protocol SesacRepositoryInterface: AnyObject {
  func requestUserInfo(
    completion: @escaping (
      Result< UserInfo,
      SesacNetworkServiceError>
    ) -> Void
  )
  
  func requestSignUp(
    userSignUpInfo: UserSignUpQuery,
    completion: @escaping (
      Result< UserInfo,
      SesacNetworkServiceError>
    ) -> Void
  )
  
  func requestWithdraw(
    completion: @escaping (
      Result< Int,
      SesacNetworkServiceError>
    ) -> Void
  )
  
  func requestUpdateUserInfo(
    userUpdateInfo: UserUpdateQuery,
    completion: @escaping (
      Result< Int,
      SesacNetworkServiceError>
    ) -> Void
  )
}
