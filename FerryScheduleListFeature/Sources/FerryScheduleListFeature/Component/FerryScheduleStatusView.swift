//
//  FerryScheduleStatusView.swift
//
//
//  Created by nakanishi wataru on 2022/05/03.
//

import SwiftUI

import AppCore

struct FerryScheduleStatusView: View {
    private let statusTitle: String
    private let statusText: String

    init(
        statusTitle: String,
        statusText: String
    ) {
        self.statusTitle = statusTitle
        self.statusText = statusText
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "info.circle")
            VStack(alignment: .leading, spacing: 8) {
                Text(statusTitle)
                    .font(.headline)
                Text(statusText)
                    .font(.caption)
            }
        }
        .padding(8)
        .background(
            Color(hex: "#F2F2F2")
        )
        .cornerRadius(8)
    }
}

