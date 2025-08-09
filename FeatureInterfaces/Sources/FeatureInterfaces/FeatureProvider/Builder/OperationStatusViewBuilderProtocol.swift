//
//  OperationStatusViewBuilderProtocol.swift
//  
//
//  Created by nakanishi wataru on 2022/04/14.
//

import SwiftUI

public protocol OperationStatusViewBuilderProtocol {
  func build(_ request: OperationStatusViewRequest) -> AnyView
}
