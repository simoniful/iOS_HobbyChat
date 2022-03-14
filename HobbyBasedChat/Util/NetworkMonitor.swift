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
