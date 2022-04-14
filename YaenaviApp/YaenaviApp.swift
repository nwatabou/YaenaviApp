//
//  YaenaviApp.swift
//  YaenaviApp
//
//  Created by nakanishi wataru on 2022/03/12.
//

import SwiftUI

import FeatureInterfaces

@main
struct YaenaviApp: App {

    private let featureProvider: FeatureProviderProtocol = FeatureProvider()

    var body: some Scene {
        WindowGroup {
            ContentView(featureProvider: featureProvider)
        }
    }
}
