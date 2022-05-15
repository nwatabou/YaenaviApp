//
//  FerryScheduleListView.swift
//
//
//  Created by nakanishi wataru on 2022/05/03.
//

import SwiftUI
import Parchment

struct FerryScheduleListView: View {
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
            PageView(items: items) { item in
                ScheduleView(
                    schedule: "10:30",
                    company: "安栄観光",
                    status: .normal
                )
            }
            .background(
                Color.white
            )
        }
    }
}
