//
//  FerryScheduleListView.swift
//
//
//  Created by nakanishi wataru on 2022/05/03.
//

import SwiftUI
import Parchment

struct FerryScheduleListView: View {
    @ObservedObject
    private var viewModel: FerryScheduleListViewModel

    init(
        viewModel: FerryScheduleListViewModel
    ) {
        self.viewModel = viewModel
    }

    let items = [
        PagingIndexItem(index: 0, title: "石垣発"),
        PagingIndexItem(index: 1, title: "波照間発")
    ]

    var body: some View {
        VStack {
            FerryScheduleStatusView(
                statusTitle: "安栄観光",
                statusText: "海上時化のため、石垣港15:20発・上原港16:30発便から欠航となります。"
            )
            .padding(16)
            PageView(items: viewModel.state.pagingItems) { item in
                List {
                    if item.index == 0 {
                        ForEach(viewModel.state.outwardRouteSchedules, id: \.self) { schedule in
                            ScheduleView(
                                schedule: schedule.time,
                                company: schedule.company.displayName,
                                status: schedule.status
                            )
                        }
                    } else if item.index == 1 {
                        ForEach(viewModel.state.returnRouteSchedules, id: \.self) { schedule in
                            ScheduleView(
                                schedule: schedule.time,
                                company: schedule.company.displayName,
                                status: schedule.status
                            )
                        }
                    }
                }
            }
            .background(
                Color.white
            )
            .onAppear(perform: {
                viewModel.action.onAppear.send()
            })
            .onDisappear(perform: {
                viewModel.action.onDisappear.send()
            })
        }
    }
}
