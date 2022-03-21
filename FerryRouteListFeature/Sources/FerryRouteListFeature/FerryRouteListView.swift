//
//  FerryRouteListView.swift
//  
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI
import AppCore

public struct FerryRouteListView: View {
    // TODO: Temporary data
    private let routeList: [RouteStatusResponse] = [
        .init(name: "波照間航路", status: "通常運航"),
        .init(name: "上原航路", status: "通常運航"),
        .init(name: "鳩間航路", status: "通常運航"),
        .init(name: "大原航路", status: "通常運航"),
        .init(name: "竹富航路", status: "通常運航"),
        .init(name: "小浜航路", status: "通常運航"),
        .init(name: "黒島航路", status: "通常運航")
    ]

    public init() {}

    public var body: some View {
        NavigationView {
            List(routeList) { route in
                NavigationLink(
                    destination: {},
                    label: {
                        RouteView(
                            routeName: route.name,
                            status: route.status
                        )
                    }
                )
            }
            .listStyle(.plain)
            .navigationTitle("航路の選択")
        }
    }
}
