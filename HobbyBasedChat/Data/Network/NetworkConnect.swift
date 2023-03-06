//
//  NetworkConnect.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/04/06.
//

import Foundation
import Alamofire

final class NetworkConnect {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
