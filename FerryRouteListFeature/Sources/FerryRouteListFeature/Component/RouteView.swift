//
//  RouteView.swift
//  
//
//  Created by nakanishi wataru on 2022/03/21.
//

import SwiftUI

import FeatureInterfaces

struct RouteView: View {
    private let routeName: String
    private let status: FerryRouteStatus

    init(
        routeName: String,
        status: FerryRouteStatus
    ) {
        self.routeName = routeName
        self.status = status
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 8) {
                    Text(routeName)
                        .font(.title2)
                    Spacer()
                }
                HStack(alignment: .center, spacing: 8) {
                    Text(status.displayText)
                        .font(.caption)
                        .foregroundColor(Color(status.textColor))
                    Spacer()
                }
            }
        }
    }
}
