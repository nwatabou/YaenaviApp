//
//  FerryApiProtocol.swift
//  
//
//  Created by nakanishi wataru on 2022/03/06.
//

import Foundation

public protocol FerryApiProtocol {
  func fetchRouteStatuses(
    completion: @escaping (Result<RouteStatusListResponse, Error>) -> Void
  )
  
  func fetchRouteScheduleList(
    routePrefix: String,
    completion: @escaping (Result<RouteScheduleListResponse, Error>) -> Void
  )
}
