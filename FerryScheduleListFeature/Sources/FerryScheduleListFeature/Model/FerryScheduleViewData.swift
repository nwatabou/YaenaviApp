//
//  FerryScheduleViewData.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Foundation

import AppCore
import FeatureInterfaces
import Parchment

struct FerryScheduleListViewData {
    let name: String
    let dateString: String
    let statusInfo: String
    let outwardRouteSchedule: FerryRoutePortViewData
    let returnRouteSchedule: FerryRoutePortViewData
}

struct FerryRoutePortViewData {
    let portName: String
    let schedules: [FerryScheduleViewData]
}

struct FerryScheduleViewData: Identifiable, Hashable {
    typealias ID = String

    let id: ID
    let time: String
    let company: FerryCompany
    let status: FerryStatus

    init(
        time: String,
        company: FerryCompany,
        status: FerryStatus
    ) {
        self.id = time
        self.time = time
        self.company = company
        self.status = status
    }
}
