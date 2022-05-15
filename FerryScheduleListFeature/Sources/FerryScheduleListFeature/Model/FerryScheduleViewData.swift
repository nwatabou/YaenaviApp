//
//  FerryScheduleViewData.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Foundation

import AppCore
import FeatureInterfaces

struct FerryScheduleListViewData {
    let name: String
    let dateString: String
    let statusInfo: String
    let schedules: [FerryScheduleViewData]
}

struct FerryScheduleViewData {
    let time: String
    let company: FerryCompany
    let status: FerryStatus
}
