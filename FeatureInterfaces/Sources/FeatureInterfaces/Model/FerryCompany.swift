//
//  FerryCompany.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Foundation

/// 運航会社
public enum FerryCompany {
  case aneiKankou
  case yaeyamaKankou
  
  public var displayName: String {
    switch self {
    case .aneiKankou:
      return "安栄観光"
    case .yaeyamaKankou:
      return "八重山観光"
    }
  }
}
