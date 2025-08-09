//
//  FerryScheduleListTranslator.swift
//  
//
//  Created by nakanishi wataru on 2022/05/15.
//

import Foundation

import AppCore
import FeatureInterfaces

enum FerryScheduleListTranslator {
    static func translateToFerrySchedules(
        from data: [RouteScheduleResponse],
        company: FerryCompany
    ) -> [FerryScheduleViewData] {
        data.map {
            FerryScheduleViewData(
                time: $0.time,
                company: company,
                status: FerryStatus(rawValue: $0.status)
            )
        }
    }
}
