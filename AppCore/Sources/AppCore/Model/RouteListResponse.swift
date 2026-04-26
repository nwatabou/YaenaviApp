//
//  RouteListResponse.swift
//  AppCore
//
//  Created by Wataru Nakanishi on 2026/04/26.
//

import Foundation

public struct RouteListResponse {
  public let information: String?
  public let routes: [RouteResponse]

  public init(information: String?, routes: [RouteResponse]) {
    self.information = information
    self.routes = routes
  }
}

public struct RouteResponse {
  public let name: String
  public let status: RouteOperationStatus

  public init(name: String, status: RouteOperationStatus) {
    self.name = name
    self.status = status
  }
}

public enum RouteOperationStatus {
  /// ◯ 通常運航
  case normal
  /// △ 一部運休
  case partial
  /// ✕ 全便欠航
  case suspension
}

