//
//  NetworkMonitor.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import UIKit
import Network
import Toast

extension UIViewController {
  func networkMoniter() {
    let monitor = NWPathMonitor()
    monitor.pathUpdateHandler = {
      path in
      if path.status == .satisfied {
        DispatchQueue.main.async {
          return
        }
      } else {
        DispatchQueue.main.async {
          self.view.makeToast("네트워크 연결이 원활하지 않습니다.", position: .center)
        }
      }
    }
    let queue = DispatchQueue(label: "Network")
    monitor.start(queue: queue)
  }
}

import Foundation
import Alamofire

final class NetworkConnect {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

//final class NetworkMonitorService{
//
//    static let shared = NetworkMonitorService()
//
//    private let queue = DispatchQueue.global()
//    private let monitor: NWPathMonitor
//    public private(set) var isConnected: Bool = false
//    public private(set) var connectionType: ConnectionType = .unknown
//
//    enum ConnectionType {
//        case wifi
//        case cellular
//        case ethernet
//        case unknown
//    }
//
//    private init(){
//        monitor = NWPathMonitor()
//    }
//
//    public func startMonitoring(){
//        print("startMonitoring 호출")
//        monitor.start(queue: queue)
//        monitor.pathUpdateHandler = { [weak self] path in
//            print("path :\(path)")
//
//            self?.isConnected = path.status == .satisfied
//            self?.getConenctionType(path)
//
//            if self?.isConnected == true{
//                print("연결이 된 상태!")
//            }else{
//                print("연결 안된 상태!")
//            }
//        }
//    }
//
//    public func stopMonitoring(){
//        print("stopMonitoring 호출")
//        monitor.cancel()
//    }
//
//    private func getConenctionType(_ path:NWPath) {
//        print("getConenctionType 호출")
//        if path.usesInterfaceType(.wifi){
//            connectionType = .wifi
//            print("wifi에 연결")
//
//        }else if path.usesInterfaceType(.cellular) {
//            connectionType = .cellular
//            print("cellular에 연결")
//
//        }else if path.usesInterfaceType(.wiredEthernet) {
//            connectionType = .ethernet
//            print("wiredEthernet에 연결")
//
//        }else {
//            connectionType = .unknown
//            print("unknown ..")
//        }
//    }
//}

