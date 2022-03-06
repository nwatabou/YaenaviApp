// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YaenaviAppPackage",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "YaenaviAppPackage",
            targets: ["YaenaviAppPackage"])
    ],
    dependencies: [
        .package(name: "Kanna", url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2")
    ],
    targets: [
        .target(
            name: "YaenaviAppPackage",
            dependencies: [
                "Kanna"
            ]
        ),
        // MARK: - Test Targets
        .testTarget(
            name: "YaenaviAppPackageTests",
            dependencies: [
                "YaenaviAppPackage"
            ]
        ),
    ]
)
