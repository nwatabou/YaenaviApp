//
//  ScheduleView.swift
//  
//
//  Created by nakanishi wataru on 2022/05/05.
//

import SwiftUI

import FeatureInterfaces

struct ScheduleView: View {
    private let schedule: String
    private let company: String
    private let status: FerryStatus

    init(
        schedule: String,
        company: String,
        status: FerryStatus
    ) {
        self.schedule = schedule
        self.company = company
        self.status = status
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Text(schedule)
                .font(.body)
                .foregroundColor(Color.black)
            Spacer()
            Text(company)
                .font(.body)
                .foregroundColor(.gray)
            status.displayMark
        }
        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}
