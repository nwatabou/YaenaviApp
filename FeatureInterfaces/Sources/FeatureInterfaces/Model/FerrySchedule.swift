//
//  FerrySchedule.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import Foundation

public struct FerrySchedule {
    public let status: RouteStatus
    public let time: String

    public init(
        status: RouteStatus,
        time: String
    ) {
        self.status = status
        self.time = time
    }
}
