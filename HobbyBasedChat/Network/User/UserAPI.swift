//
//  UserAPI.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import Moya

class UserAPI {
    static let provider = MoyaProvider<UserService>()
    
    static func requestUserInfo(idToken: String, completion: @escaping (User?, Error?, Int?) -> ()) {
        
        provider.request(.getUser(idToken: idToken)) { result in
            switch result {
            case let .success(response):
                let user = try? response.map(User.self)
                let statusCode = response.statusCode
                completion(user, nil, statusCode)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(nil, error, statusCode)
            }
        }
    }
    
    
    static func requestSignUp(idToken: String, request: SignUp, completion: @escaping (Int?, Error?) -> ()) {
        
        provider.request(.signUp(idToken: idToken, request)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestWithdraw(idToken: String, completion: @escaping (Int?, Error?) -> ()) {

        provider.request(.withdraw(idToken: idToken)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestUpdateFCMToken(idToken: String, FCMToken: String, completion: @escaping (Int?, Error?) -> ()) {
        
        provider.request(.updateFCMtoken(idToken: idToken, FCMtoken: FCMToken)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestUpdateMyPage(idToken: String, request: UpdateInfo, completion: @escaping (Int?, Error?) -> ()) {
        
        provider.request(.updateMypage(idToken: idToken, request)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestReport(idToken: String, request: ReportRequest, completion: @escaping (Int?, Error?) -> ()) {
        provider.request(.report(idToken: idToken, request)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestUpdateSesacBackground(idToken: String, sesac: Int, background: Int, completion: @escaping (Int?, Error?) -> ()) {
        provider.request(.updateSesacBackground(idToken: idToken, sesac: sesac, background: background)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestPurchaseItem(idToken: String, receipt: String, product: String, completion: @escaping (Int?, Error?) -> ()) {
        provider.request(.purchaseItem(idToken: idToken, receipt: receipt, product: product)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                completion(statusCode, nil)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(statusCode, error)
            }
        }
    }
    
    static func requestUserInfoInShop(idToken: String, completion: @escaping (User?, Error?, Int?) -> ()) {
        provider.request(.getUserInShop(idToken: idToken)) { result in
            switch result {
            case let .success(response):
                let user = try? response.map(User.self)
                let statusCode = response.statusCode
                completion(user, nil, statusCode)
            case let .failure(error):
                let statusCode = error.response?.statusCode
                completion(nil, error, statusCode)
            }
        }
    }
}
