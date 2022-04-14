//
//  FerryRouteViewData.swift
//  
//
//  Created by nakanishi wataru on 2022/03/26.
//

import Foundation

import FeatureInterfaces

struct FerryRouteViewData: Hashable, Identifiable {
    typealias ID = String

    let id: ID
    let route: FerryRoute
    let status: FerryRouteStatus

    init(
        route: FerryRoute,
        status: FerryRouteStatus
    ) {
        self.id = route.displayName
        self.route = route
        self.status = status
    }
}
