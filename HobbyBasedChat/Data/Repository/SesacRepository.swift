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
  func requestUserInfo(completion: @escaping (Result<UserInfo, SesacTargetError>) -> Void) {
    provider.request(.getUserInfo) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(UserInfoResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
      }
    }
  }
  
  func requestSignUp(userSignUpInfo: UserSignUpQuery, completion: @escaping (Result<UserInfo, SesacTargetError>) -> Void ) {
    let requestDTO = UserRegisterInfoRequestDTO(userSignUpInfo: userSignUpInfo)
    provider.request(.register(parameters: requestDTO.toDictionary)) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(UserInfoResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
      }
    }
  }
  
  func requestWithdraw(completion: @escaping (Result<Int, SesacTargetError>) -> Void ) {
    provider.request(.withdraw) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestUpdateUserInfo(
    userUpdateInfo: UserUpdateQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  ) {
    let requestDTO = UserUpdateRequestDTO(userUpdateInfo: userUpdateInfo)
    provider.request(.updateMyPage(parameters: requestDTO.toDictionary)) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestOnqueue(
    userLocationInfo: Coordinate,
    completion: @escaping (
      Result< Onqueue,
      SesacTargetError>
    ) -> Void
  ) {
    let requestDTO = OnqueueRequestDTO(userLocationInfo: userLocationInfo)
    provider.request(.onqueue(parameters: requestDTO.toDictionary)) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(OnqueueResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
      }
    }
  }
  
  func requestSesacSearch(
    sesacSearchQuery: SesacSearchQuery,
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  ) {
    let requestDTO = SesacSearchRequestDTO(sesacSearch: sesacSearchQuery)
    provider.request(.searchSesac(parameters: requestDTO.toDictionary)) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestPauseSearchSesac(
    completion: @escaping (
      Result< Int,
      SesacTargetError>
    ) -> Void
  ) {
    provider.request(.pauseSearchSesac) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestSesacFriend(
    sesacFriendQuery: SesacFriendQuery,
    completion: @escaping (
      Result<Int,
      SesacTargetError>
    ) -> Void
  ) {
    let requestDTO = SesacFriendRequestDTO(sesacFriendQuery: sesacFriendQuery)
    provider.request(.requestHobbyFriend(parameters: requestDTO.toDictionary)) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestAcceptSesacFriend(
    sesacFriendQuery: SesacFriendQuery,
    completion: @escaping (
      Result<Int,
      SesacTargetError>) -> Void
  ) {
    let requestDTO = SesacFriendRequestDTO(sesacFriendQuery: sesacFriendQuery)
    provider.request(.acceptHobbyFriend(parameters: requestDTO.toDictionary)) { result in
      self.process(result: result, completion: completion)
    }
  }
  
  func requestMyQueueState(
    completion: @escaping (
      Result<MyQueueState,
      SesacTargetError>) -> Void
  ) {
    provider.request(.myQueueState) { result in
      switch result {
      case .success(let response):
        let data = try? JSONDecoder().decode(MyQueueStateResponseDTO.self, from: response.data)
        completion(.success(data!.toDomain()))
      case .failure(let error):
        completion(.failure(
          SesacTargetError(
            rawValue: error.response!.statusCode
          ) ?? .unknown
        ))
      }
    }
  }
  
  func requestSendChat(
      to id: String,
      chatQuery: ChatQuery,
      completion: @escaping (
          Result< Chat,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = ChatRequestDTO(chatQuery: chatQuery)
    provider.request(.sendChatMessage(parameters: requestDTO.toDictionary, id: id)) { result in
        print(result)
        switch result {
        case .success(let response):
            let data = try? JSONDecoder().decode(ChatDTO.self, from: response.data)
            completion(.success(data!.toDomain()))
        case .failure(let error):
            completion(.failure(
              SesacTargetError(
                rawValue: error.response!.statusCode
              ) ?? .unknown)
            )
        }
    }
  }

  func requestChat(
      to id: String,
      dateString: String,
      completion: @escaping (
          Result< ChatList,
          SesacTargetError>
      ) -> Void
  ) {
    provider.request(.getChatInfo(id: id, date: dateString)) { result in
        print(result)
        switch result {
        case .success(let response):
            let data = try? JSONDecoder().decode(ChatResponseDTO.self, from: response.data)
            completion(.success(data!.toDomain()))
        case .failure(let error):
            completion(.failure(
              SesacTargetError(
                rawValue: error.response!.statusCode
              ) ?? .unknown)
            )
        }
    }
  }

  func requestDodge(
      dodgeQuery: DodgeQuery,
      completion: @escaping (
          Result< Int,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = DodgeRequestDTO(dodgeQuery: dodgeQuery)
    provider.request(.dodge(parameters: requestDTO.toDictionary)) { result in
        self.process(result: result, completion: completion)
    }
  }

  func reqeustWriteReview(
      to id: String,
      review: ReviewQuery,
      completion: @escaping (
          Result< Int,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = ReviewRequestDTO(review: review)
    provider.request(.writeReview(parameters: requestDTO.toDictionary, id: id)) { result in
        print(result)
        self.process(result: result, completion: completion)
    }
  }

  func requestReport(
      report: ReportQuery,
      completion: @escaping (
          Result< Int,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = ReportRequestDTO(report: report)
    provider.request(.report(parameters: requestDTO.toDictionary)) { result in
        self.process(result: result, completion: completion)
    }
  }

  func requestShopUserInfo(
      completion: @escaping (
          Result< UserInfo,
          SesacTargetError>
      ) -> Void
  ) {
    provider.request(.shopUserInfo) { result in
        switch result {
        case .success(let response):
            let data = try? JSONDecoder().decode(UserInfoResponseDTO.self, from: response.data)
            completion(.success(data!.toDomain()))
        case .failure(let error):
            completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
        }
    }
  }

  func requestUpdateShop(
      updateShop: UpdateShopQuery,
      completion: @escaping (
          Result< Int,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = UpdateShopRequestDTO(updateShop: updateShop)
    provider.request(.updateShop(parameters: requestDTO.toDictionary)) { result in
        self.process(result: result, completion: completion)
    }
  }

  func requestPurchaseItem(
      itemQuery: PurchaseItemQuery,
      completion: @escaping (
          Result< Int,
          SesacTargetError>
      ) -> Void
  ) {
    let requestDTO = PurchaseShopItemRequestDTO(itemInfo: itemQuery)
    provider.request(.purchaseShopItem(parameters: requestDTO.toDictionary)) { result in
        self.process(result: result, completion: completion)
    }
  }
}

extension SesacRepository {
  private func process<T: Codable, E>(
    type: T.Type,
    result: Result<Response, MoyaError>,
    completion: @escaping (Result<E, SesacTargetError>) -> Void
  ) {
    switch result {
    case .success(let response):
      let data = try? JSONDecoder().decode(type, from: response.data)
      completion(.success(data as! E))
    case .failure(let error):
      completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
    }
  }
  
  private func process(
    result: Result<Response, MoyaError>,
    completion: @escaping (Result<Int, SesacTargetError>) -> Void
  ) {
    switch result {
    case .success(let response):
      completion(.success(response.statusCode))
    case .failure(let error):
      print(error)
      completion(.failure(SesacTargetError(rawValue: error.response!.statusCode) ?? .unknown))
    }
  }
}
