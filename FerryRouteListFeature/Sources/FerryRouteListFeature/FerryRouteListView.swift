//
//  FerryRouteListView.swift
//  
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI
import AppCore

struct FerryRouteListView: View {
    @ObservedObject
    private var viewModel: FerryRouteListViewModel

    init(
        viewModel: FerryRouteListViewModel
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.state.routeList, id: \.self) { route in
                    RouteView(
                        routeName: route.name,
                        status: route.status
                    )
                }
            }
            .padding(.all, 16)
            .listStyle(.plain)
            .navigationTitle("航路の選択")
        }
        .onAppear(perform: {
            viewModel.action.onAppear.send()
        })
    }
}
