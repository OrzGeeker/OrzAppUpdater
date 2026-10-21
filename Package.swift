// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrzAppUpdater",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "OrzAppUpdaterCore", targets: ["OrzAppUpdaterCore"]),
        .library(name: "OrzAppUpdater", targets: ["OrzAppUpdater"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle.git", from: "2.9.0")
    ],
    targets: [
        .target(name: "OrzAppUpdaterCore"),
        .testTarget(name: "OrzAppUpdaterCoreTests", dependencies: ["OrzAppUpdaterCore"]),
        .target(name: "OrzAppUpdater",dependencies: [.product(name: "Sparkle", package: "sparkle")])
    ]
)
