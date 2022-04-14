//
//  FerryStatus.swift
//
//
//  Created by nakanishi wataru on 2022/03/06.
//

import Foundation
import UIKit

/// 各航路の運行状況
public enum FerryRouteStatus {
    case normal
    case partial
    case outOfService

    public var displayText: String {
        switch self {
        case .normal:
            return "全便通常運航"
        case .partial:
            return "一部欠航"
        case .outOfService:
            return "全便欠航"
        }
    }

    public var textColor: UIColor {
        switch self {
        case .normal:
            return .systemBlue
        case .partial:
            return .systemYellow
        case .outOfService:
            return .systemRed
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case "〇", // 八重山観光の表記
             "◯", // 安永観光の表記
             "operation_normal": // 各航路の状態
            self = .normal
        case "×", // 八重山観光の表記
             "✕", // 安永観光の表記
             "operation_suspension": // 各航路の状態
            self = .outOfService
        case "operation_partial": // 各航路の状態
            self = .partial
        default:
            return nil
        }
    }
}
