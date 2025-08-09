//
//  FerryScheduleListViewBuilderProtocol.swift
//  
//
//  Created by nakanishi wataru on 2022/05/03.
//

import SwiftUI

public protocol FerryScheduleListViewBuilderProtocol {
  func build(_ request: FerryScheduleListViewRequest) -> AnyView
}
