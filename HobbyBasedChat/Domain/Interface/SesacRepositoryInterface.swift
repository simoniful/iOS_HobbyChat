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
      SesacTargetError>
    ) -> Void
  )
  
  func requestSignUp(
    userSignUpInfo: UserSignUpQuery,
    completion: @escaping (
      Result< UserInfo,
      SesacTargetError>
    ) -> Void
  )
  
  func requestWithdraw(
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestUpdateUserInfo(
    userUpdateInfo: UserUpdateQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestOnqueue(
    userLocationInfo: Coordinate,
    completion: @escaping (
      Result< Onqueue,
      SesacTargetError>
    ) -> Void
  )
  
  func requestSesacSearch(
    sesacSearchQuery: SesacSearchQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestPauseSearchSesac(
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestSesacFriend(
    sesacFriendQuery: SesacFriendQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestAcceptSesacFriend(
    sesacFriendQuery: SesacFriendQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  )
  
  func requestMyQueueState(                    
    completion: @escaping (
      Result< MyQueueState,
      SesacTargetError>
    ) -> Void
  )
}
