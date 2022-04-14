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

class FeatureProvider: FeatureProviderProtocol {
    init() {}
}

// MARK: - For FerryRouteListFeature

extension FeatureProvider {

    func build(_ request: FerryRouteListViewRequest) -> AnyView {
        let view = FerryRouteListViewBuilder.build()
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
