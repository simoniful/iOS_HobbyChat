//
//  UserService.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import Moya

enum UserService {
    case getUser(idToken: String)
    case signUp(idToken: String, SignUp)
    case withdraw(idToken: String)
    case updateFCMtoken(idToken: String, FCMtoken: String)
    case updateMypage(idToken: String, UpdateInfo)
    case report(idToken: String, ReportRequest)
    case updateSesacBackground(idToken: String, sesac: Int, background: Int)
    case purchaseItem(idToken: String, receipt: String, product: String)
    case getUserInShop(idToken: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "http://test.monocoding.com:35484/")!
    }
    
    var path: String {
        switch self {
        case .getUser: return "user"
        case .signUp: return "user"
        case .withdraw: return "user/withdraw"
        case .updateFCMtoken: return "user/update_fcm_token"
        case .updateMypage: return "user/update/mypage"
        case .report: return "user/report"
        case .updateSesacBackground: return "user/update/shop"
        case .purchaseItem: return "user/shop/ios"
        case .getUserInShop: return "user/shop/myinfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser: return .get
        case .signUp: return .post
        case .withdraw: return .post
        case .updateFCMtoken: return .put
        case .updateMypage: return .post
        case .report: return .post
        case .updateSesacBackground: return .post
        case .purchaseItem: return .post
        case .getUserInShop: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
            
        case .signUp(_, let request):
            return .requestParameters(parameters: [
                "phoneNumber": request.phoneNumber,
                "FCMtoken": request.FCMtoken,
                "nick": request.nick,
                "birth": request.birth,
                "email": request.email,
                "gender": request.gender
            ], encoding: URLEncoding.default)
            
        case .withdraw:
            return .requestPlain
            
        case .updateFCMtoken(_, let FCMtoken):
            return .requestParameters(parameters: [
                "FCMtoken": FCMtoken
            ], encoding: URLEncoding.default)
            
        case .updateMypage(_, let request):
            return .requestParameters(parameters: [
                "searchable": request.searchable,
                "ageMin": request.ageMin,
                "ageMax": request.ageMax,
                "gender": request.gender,
                "hobby": request.hobby
            ], encoding: URLEncoding.default)
        case .report(idToken: _, let request):
            return .requestParameters(parameters: [
                "otheruid": request.otheruid,
                "reportedReputation": request.reputation,
                "comment": request.comment
            ], encoding: URLEncoding.default)
            
        case .updateSesacBackground(_, let sesac, let background):
            return .requestParameters(parameters: [
                "sesac": sesac,
                "background": background
            ], encoding: URLEncoding.default)
            
        case .purchaseItem(_, let receipt, let product):
            return .requestParameters(parameters: [
                "receipt": receipt,
                "product": product
            ], encoding: URLEncoding.default)
            
        case .getUserInShop(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUser(let idToken):
            return [
                "idtoken": idToken
            ]
        case .signUp(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .withdraw(let idToken):
            return [
                "idtoken": idToken
            ]
        case .updateFCMtoken(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .updateMypage(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .report(let idToken, _):
            return [
                "idtoken": idToken
            ]
        case .updateSesacBackground(let idToken, _, _):
            return [
                "idtoken": idToken
            ]
        case .purchaseItem(let idToken, _, _):
            return [
                "idtoken": idToken
            ]
        case .getUserInShop(let idToken):
            return [
                "idtoken": idToken
            ]
        }
    }
}
