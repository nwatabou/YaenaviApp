//
//  FerryScheduleListViewBuilder.swift
//
//
//  Created by nakanishi wataru on 2022/05/03.
//

import SwiftUI

import AppCore

public enum FerryScheduleListViewBuilder {
    public static func build(
        routePrefix: String
    ) -> some View {
        let view = FerryScheduleListView(
            viewModel: FerryScheduleListViewModel(
                state: .init(),
                dependency: .init(
                    routePrefix: routePrefix,
                    ferryScheduleRepository: FerryScheduleRepository(
                        aneiKankouApi: AneiKankouApi(),
                        yaeyamaKankouApi: YaeyamaKankouApi()
                    )
                )
            )
        )

        return view
    }
}
