//
//  FerryStatus.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import SwiftUI

/// 便ごとの運行状況
public enum FerryStatus {
  case normal
  case outOfService
  case unknown
  
  public var displayMark: Image {
    switch self {
    case .normal:
      return Image(systemName: "circle")
    case .outOfService:
      return Image(systemName: "multiply")
    case .unknown:
      return Image(systemName: "minus")
    }
  }
  
  public var textColor: Color {
    switch self {
    case .normal:
      return .blue
    case .outOfService:
      return .red
    case .unknown:
      return .gray
    }
  }
  
  public init(rawValue: String) {
    switch rawValue {
    case "〇", // 八重山観光の表記
      "◯": // 安永観光の表記
      self = .normal
    case "×", // 八重山観光の表記
      "✕": // 安永観光の表記
      self = .outOfService
    default:
      self = .unknown
    }
  }
}
