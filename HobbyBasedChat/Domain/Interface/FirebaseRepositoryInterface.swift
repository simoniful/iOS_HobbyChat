//
//  FirebaseRepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/06.
//

import Foundation

protocol FirebaseRepositoryInterface: AnyObject {
  func verifyPhoneNumber(
    phoneNumber: String,
    completion: @escaping (
      Result <String,
      FirbaseNetworkServiceError>
    ) -> Void
  )
  
  func signIn(
    verifyID: String,
    certificationNumber: String,
    completion: @escaping (
      Result <Void,
      FirbaseNetworkServiceError>
    ) -> Void
  )
  
  func requestIdtoken(
    completion: @escaping (
      Result <String,
      FirbaseNetworkServiceError>
    ) -> Void
  )
}
