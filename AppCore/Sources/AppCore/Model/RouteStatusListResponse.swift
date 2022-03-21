//
//  RouteStatusListResponse.swift
//  
//
//  Created by nakanishi wataru on 2022/03/06.
//

import Foundation

/// 運航状況一覧
public struct RouteStatusListResponse {
    public let info: String?
    public let routeStatuses: [RouteStatusResponse]

    public init(
        info: String?,
        routeStatuses: [RouteStatusResponse]
    ) {
        self.info = info
        self.routeStatuses = routeStatuses
    }
}

public struct RouteStatusResponse: Hashable, Identifiable {
    public typealias ID = String

    public let id: ID
    public let name: String
    public let status: String

    public init(
        name: String,
        status: String
    ) {
        self.id = name
        self.name = name
        self.status = status
    }
}
