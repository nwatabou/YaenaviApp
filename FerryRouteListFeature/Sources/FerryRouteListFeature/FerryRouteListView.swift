//
//  FerryRouteListView.swift
//  
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI
import AppCore

import FeatureInterfaces

struct FerryRouteListView: View {
  private let featureProvider: FeatureProviderProtocol
  
  @ObservedObject
  private var viewModel: FerryRouteListViewModel
  
  init(
    featureProvider: FeatureProviderProtocol,
    viewModel: FerryRouteListViewModel
  ) {
    self.featureProvider = featureProvider
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.state.routeList, id: \.self) { viewData in
          NavigationLink(destination: featureProvider.build(FerryScheduleListViewRequest(routePrefix: viewData.route.prefix))) {
            RouteView(
              routeName: viewData.route.displayName,
              status: viewData.status
            )
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("航路の選択")
    }
    .onAppear(perform: {
      viewModel.action.onAppear.send()
    })
  }
}
