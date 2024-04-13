// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "VAFrostedGlassView",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "VAFrostedGlassView",
            targets: ["VAFrostedGlassView"]
        ),
    ],
    targets: [
        .target(
            name: "VAFrostedGlassView",
            dependencies: [],
            path: "VAFrostedGlassView/Classes"
        ),
    ]
)
