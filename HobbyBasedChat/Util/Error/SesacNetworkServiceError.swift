//
//  SesacNetworkServiceError.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

enum SesacNetworkServiceError: Int, Error {
  case duplicatedError = 201
  case inValidInputBodyError = 202
  case inValidIDTokenError = 401
  case inValidURL = 404
  case unregisterUser = 406
  case internalServerError = 500
  case internalClientError = 501
  case unknown
  
  var description: String { self.errorDescription }
}

extension SesacNetworkServiceError {
  var errorDescription: String {
    switch self {
    case .duplicatedError: return "201:DUPLICATE_ERROR"
    case .inValidInputBodyError: return "202:INVALID_INPUT_BODY_ERROR"
    case .inValidIDTokenError: return "401:INVALID_FCM_TOKEN_ERROR"
    case .inValidURL: return "404:INVALID_URL_ERROR"
    case .unregisterUser: return "406:UNREGISTER_USER_ERROR"
    case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
    case .internalClientError: return "501:INTERNAL_CLIENT_ERROR"
    default: return "UN_KNOWN_ERROR"
    }
  }
}
