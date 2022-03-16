//
//  FirebaseService.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/16.
//

import Foundation
import FirebaseAuth

class FirebaseService {
    static func requestIDToken(completion: @escaping (String?, Error?) -> ()) {
        let currentUserInstance = Auth.auth().currentUser
        currentUserInstance?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let idToken = idToken else { return }
            UserDefaults.standard.set(idToken, forKey: "FirebaseIdToken")
            completion(idToken, nil)
        }
    }
}
