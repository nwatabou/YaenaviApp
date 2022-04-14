//
//  FerrySchedule.swift
//  
//
//  Created by nakanishi wataru on 2022/04/10.
//

import Foundation

/// 便ごとの情報
public struct FerrySchedule {
    public let status: FerryStatus
    public let time: String

    public init(
        status: FerryStatus,
        time: String
    ) {
        self.status = status
        self.time = time
    }
}
