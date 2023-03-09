//
//  HomeHobbySettingSectionModel.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/09.
//

import Foundation
import RxDataSources

typealias HomeHobbySettingSectionModel = SectionModel<HobbySettingSection, HobbySettingItem>

enum HobbySettingSection: Int, Equatable {
    case near
    case selected

    init(index: Int) {
        switch index {
        case 0: self = .near
        default: self = .selected
        }
    }

    var headerTitle: String {
        switch self {
        case .near:
            return "지금 주변에는"
        case .selected:
            return "내가 하고 싶은"
        }
    }
}

enum HobbySettingItem: Equatable {
    case near(Hobby)
    case selected(Hobby)

    var hobby: Hobby {
        switch self {
        case .near(let hobby):
            return hobby
        case .selected(let hobby):
            return hobby
        }
    }
}
