//
//  ContentView.swift
//  YaenaviApp
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI

import FeatureInterfaces

struct ContentView: View {
    let featureProvider: FeatureProviderProtocol

    init(
        featureProvider: FeatureProviderProtocol
    ) {
        self.featureProvider = featureProvider
    }

    var body: some View {
        TabView {
            featureProvider.build(FerryRouteListViewRequest())
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.circle")
                        Text("航路")
                    }
                }
            featureProvider.build(OperationStatusViewRequest())
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle")
                        Text("運行状況")
                    }
                }
        }
    }
}
