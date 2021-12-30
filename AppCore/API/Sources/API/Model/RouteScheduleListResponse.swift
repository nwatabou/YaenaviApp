//
//  File.swift
//  
//
//  Created by nakanishi wataru on 2021/12/30.
//

import Foundation

/// 各航路の運航スケジュール
public struct RouteScheduleListResponse {
    public let name: String
    public let outwardRouteName: String
    public let outwardRouteSchedules: [RouteScheduleResponse]
    public let returnRouteName: String
    public let returnRouteSchedules: [RouteScheduleResponse]

    public init(
        name: String,
        outwardRouteName: String,
        outwardRouteSchedules: [RouteScheduleResponse],
        returnRouteName: String,
        returnRouteSchedules: [RouteScheduleResponse]
    ) {
        self.name = name
        self.outwardRouteName = outwardRouteName
        self.outwardRouteSchedules = outwardRouteSchedules
        self.returnRouteName = returnRouteName
        self.returnRouteSchedules = returnRouteSchedules
    }
}

public struct RouteScheduleResponse {
    public let time: String
    public let status: String

    public init(
        time: String,
        status: String
    ) {
        self.time = time
        self.status = status
    }
}
