//
//  FeatureProvider.swift
//  YaenaviApp
//
//  Created by nakanishi wataru on 2022/04/14.
//

import Foundation
import SwiftUI

import FeatureInterfaces
import FerryRouteListFeature
import OperationStatusFeature
import FerryScheduleListFeature

class FeatureProvider: FeatureProviderProtocol {
  init() {}
}

// MARK: - For FerryRouteListFeature

extension FeatureProvider {

  func build(_ request: FerryRouteListViewRequest) -> AnyView {
    let view = FerryRouteListViewBuilder.build(
      featureProvider: self
    )
    return AnyView(view)
  }
}

// MARK: - For OperationStatusFeature

extension FeatureProvider {
  func build(_ request: OperationStatusViewRequest) -> AnyView {
    // TODO: use Builder
    let view = OperationStatusView()
    return AnyView(view)
  }
}

// MARK: - For FerryScheduleListFeature

extension FeatureProvider {
  func build(_ request: FerryScheduleListViewRequest) -> AnyView {
    let view = FerryScheduleListViewBuilder.build(
      routePrefix: request.routePrefix
    )
    return AnyView(view)
  }
}
