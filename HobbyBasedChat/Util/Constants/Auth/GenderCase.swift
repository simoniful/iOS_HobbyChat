//
//  GenderCase.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/07.
//

import Foundation

enum GenderCase: Int {
    case total = -1
    case woman = 0
    case man = 1

    init(value: Int) {
        switch value {
        case -1: self = .total
        case 0: self = .woman
        case 1: self = .man
        default: self = .total
        }
    }

    var value: Int {
        switch self {
        case .woman:
            return 0
        case .man:
            return 1
        case .total:
            return -1
        }
    }
}
