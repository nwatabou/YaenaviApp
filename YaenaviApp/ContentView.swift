//
//  ContentView.swift
//  YaenaviApp
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI

import FerryRouteListFeature
import OperationStatusFeature

struct ContentView: View {
    var body: some View {
        TabView {
            FerryRouteListViewBuilder.build()
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.circle")
                        Text("航路")
                    }
                }
            OperationStatusView()
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle")
                        Text("運行状況")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
