//
//  FerryRouteListViewBuilder.swift
//  
//
//  Created by nakanishi wataru on 2022/03/26.
//

import Foundation
import SwiftUI

import AppCore
import FeatureInterfaces

public enum FerryRouteListViewBuilder {
    public static func build(
        featureProvider: FeatureProviderProtocol
    ) -> some View {
        let ferryRouteRepository = FerryRouteRepository(
            aneiKankouApi: AneiKankouApi(),
            yaeyamaKankouApi: YaeyamaKankouApi()
        )
        let viewModel = FerryRouteListViewModel(
            state: .init(),
            dependency: .init(ferryRouteRepository: ferryRouteRepository)
        )
        let view = FerryRouteListView(
            featureProvider: featureProvider,
            viewModel: viewModel
        )

        return view
    }
}
