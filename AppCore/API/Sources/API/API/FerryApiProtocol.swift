//
//  FerryApiProtocol.swift
//  
//
//  Created by nakanishi wataru on 2021/12/31.
//

import Foundation

public protocol FerryApiProtocol {
    func fetchRouteStatuses(
        success: @escaping (RouteStatusListResponse) -> Void,
        failure: @escaping (Error) -> Void
    )

    func fetchRouteScheduleList(
        success: @escaping ([RouteScheduleListResponse]) -> Void,
        failure: @escaping (Error) -> Void
    )
}
