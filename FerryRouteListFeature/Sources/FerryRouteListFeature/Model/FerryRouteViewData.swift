//
//  FerryRouteViewData.swift
//  
//
//  Created by nakanishi wataru on 2022/03/26.
//

import Foundation

struct FerryRouteViewData: Hashable, Identifiable {
    typealias ID = String

    let id: ID
    let name: String
    let status: String

    init(
        name: String,
        status: String
    ) {
        self.id = name
        self.name = name
        self.status = status
    }
}
