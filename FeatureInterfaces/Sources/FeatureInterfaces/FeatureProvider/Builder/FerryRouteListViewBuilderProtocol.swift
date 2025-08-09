//
//  FerryRouteListViewBuilderProtocol.swift
//
//
//  Created by nakanishi wataru on 2022/04/14.
//

import SwiftUI

public protocol FerryRouteListViewBuilderProtocol {
  func build(_ request: FerryRouteListViewRequest) -> AnyView
}
