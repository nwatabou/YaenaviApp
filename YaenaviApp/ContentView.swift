//
//  ContentView.swift
//  YaenaviApp
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FerryRouteListView()
                .tabItem {
                    VStack {
                        Image(systemName: "mappin.circle")
                        Text("航路")
                    }
                }
            InfomationView()
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
