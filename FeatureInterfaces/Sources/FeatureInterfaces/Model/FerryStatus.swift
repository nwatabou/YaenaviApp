//
//  FerryStatus.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import Foundation
import UIKit

/// 便ごとの運行状況
public enum FerryStatus {
    case normal
    case outOfService

    public var displayMark: UIImage? {
        switch self {
        case .normal:
            return UIImage(systemName: "circle")
        case .outOfService:
            return UIImage(systemName: "multiply")
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case "〇", // 八重山観光の表記
             "◯": // 安永観光の表記
            self = .normal
        case "×", // 八重山観光の表記
             "✕": // 安永観光の表記
            self = .outOfService
        default:
            return nil
        }
    }
}
