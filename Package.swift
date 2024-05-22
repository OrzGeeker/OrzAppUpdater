// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrzAppUpdater",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "OrzAppUpdater", targets: ["OrzAppUpdater"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle.git", from: "2.6.2")
    ],
    targets: [
        .target(name: "OrzAppUpdater",dependencies: [.product(name: "Sparkle", package: "sparkle")])
    ]
)
