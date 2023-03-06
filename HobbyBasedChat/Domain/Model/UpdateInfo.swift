//
//  UpdateInfo.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/20.
//

import Foundation

struct UpdateInfo {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

extension UpdateInfo {
    var fromUserDefaultValue: UpdateInfo {
        let searchable = UserDefaults.standard.integer(forKey: "searchable")
        let ageMin = UserDefaults.standard.integer(forKey: "ageMin")
        let ageMax = UserDefaults.standard.integer(forKey: "ageMax")
        let gender = UserDefaults.standard.integer(forKey: "gender")
        let hobby = UserDefaults.standard.string(forKey: "hobby") ?? ""
        
        return UpdateInfo(
            searchable: searchable,
            ageMin: ageMin,
            ageMax: ageMax,
            gender: gender,
            hobby: hobby
        )
    }
}
