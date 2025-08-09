// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FerryScheduleListFeature",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FerryScheduleListFeature",
            targets: ["FerryScheduleListFeature"]),
    ],
    dependencies: [
        .package(name: "FeatureInterfaces", path: "../FeatureInterfaces"),
        .package(name: "AppCore", path: "../AppCore"),
        .package(url: "https://github.com/rechsteiner/Parchment", from: "3.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FerryScheduleListFeature",
            dependencies: [
                "FeatureInterfaces",
                "AppCore",
                "Parchment"
            ]
        ),
        .testTarget(
            name: "FerryScheduleListFeatureTests",
            dependencies: ["FerryScheduleListFeature"]),
    ]
)
