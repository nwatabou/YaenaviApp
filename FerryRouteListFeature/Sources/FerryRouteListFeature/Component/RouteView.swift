//
//  RouteView.swift
//  
//
//  Created by nakanishi wataru on 2022/03/21.
//

import SwiftUI

struct RouteView: View {
    private let routeName: String
    private let status: String

    init(
        routeName: String,
        status: String
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
                    Text(status)
                        .font(.caption)
                    Spacer()
                }
            }
            Image(systemName: "chevron.right")
        }
    }
}
