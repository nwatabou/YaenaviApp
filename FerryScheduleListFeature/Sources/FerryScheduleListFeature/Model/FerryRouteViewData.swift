//
//  FerryRouteViewData.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import Foundation

import FeatureInterfaces

struct FerryRouteViewData {
    let routeName: String
    let outwardRoute: FerryScheduleViewData
    let returnRoute: FerryScheduleViewData

    init(
        routeName: String,
        outwardRoute: FerryScheduleViewData,
        returnRoute: FerryScheduleViewData
    ) {
        self.routeName = routeName
        self.outwardRoute = outwardRoute
        self.returnRoute = returnRoute
    }
}
