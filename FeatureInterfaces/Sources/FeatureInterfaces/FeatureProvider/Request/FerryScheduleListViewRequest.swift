//
//  FerryScheduleListViewRequest.swift
//  
//
//  Created by nakanishi wataru on 2022/05/03.
//

import Foundation

public struct FerryScheduleListViewRequest {
    public let routePrefix: String

    public init(
        routePrefix: String
    ) {
        self.routePrefix = routePrefix
    }
}
