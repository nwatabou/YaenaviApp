//
//  RouteStatus.swift
//
//
//  Created by nakanishi wataru on 2022/03/06.
//

import Foundation

public enum RouteStatus: RawRepresentable {
    case normal
    case cancel
    case outOfService

    public var rawValue: String {
        switch self {
        case .normal:
            return "通常運航"
        case .cancel:
            return "欠航"
        case .outOfService:
            return "-"
        }
    }

    public init(rawValue: String) {
        switch rawValue {
        case "〇", // for 八重山観光
             "◯": // for 安永観光
            self = .normal
        case "×", // for 八重山観光
             "✕": // for 安永観光
            self = .cancel
        default:
            self = .outOfService
        }
    }
}
