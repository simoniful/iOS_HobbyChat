//
//  SesacRepository.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/08.
//
import Foundation
import Moya
import RxSwift

final class SesacRepository: SesacRepositoryInterface {
  let provider: MoyaProvider<SesacTarget>
  init() { provider = MoyaProvider<SesacTarget>() }
}

extension SesacRepository {
  func requestUserInfo(completion: @escaping (Result<UserInfo, SesacNetworkServiceError>) -> Void) {
    provider.request(.getUserInfo) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(UserInfoResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(SesacNetworkServiceError(rawValue: error.response!.statusCode) ?? .unknown))
      }
    }
  }
  
  func requestSignUp(userSignUpInfo: UserSignUpQuery, completion: @escaping (Result<UserInfo, SesacNetworkServiceError>) -> Void ) {
    let requestDTO = UserRegisterInfoRequestDTO(userSignUpInfo: userSignUpInfo)
    provider.request(.register(parameters: requestDTO.toDictionary)) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(UserInfoResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(SesacNetworkServiceError(rawValue: error.response!.statusCode) ?? .unknown))
      }
    }
  }
  
  func requestWithdraw(completion: @escaping (Result<Int, SesacNetworkServiceError>) -> Void ) {
    provider.request(.withdraw) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestUpdateUserInfo(
    userUpdateInfo: UserUpdateQuery,
    completion: @escaping (
      Result< Int,
      SesacNetworkServiceError>
    ) -> Void
  ) {
    let requestDTO = UserUpdateRequestDTO(userUpdateInfo: userUpdateInfo)
    provider.request(.updateMyPage(parameters: requestDTO.toDictionary)) { result in
      self.process(result: result, completion: completion)
    }
  }
}

extension SesacRepository {
  private func process<T: Codable, E>(
    type: T.Type,
    result: Result<Response, MoyaError>,
    completion: @escaping (Result<E, SesacNetworkServiceError>) -> Void
  ) {
    switch result {
    case .success(let response):
      let data = try? JSONDecoder().decode(type, from: response.data)
      completion(.success(data as! E))
    case .failure(let error):
      completion(.failure(SesacNetworkServiceError(rawValue: error.response!.statusCode) ?? .unknown))
    }
  }
  
  private func process(
    result: Result<Response, MoyaError>,
    completion: @escaping (Result<Int, SesacNetworkServiceError>) -> Void
  ) {
    switch result {
    case .success(let response):
      completion(.success(response.statusCode))
    case .failure(let error):
      print(error)
      completion(.failure(SesacNetworkServiceError(rawValue: error.response!.statusCode) ?? .unknown))
    }
  }
}
