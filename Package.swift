// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ScrollKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "ScrollKit",
            targets: ["ScrollKit"]
        ),
    ],
    targets: [
        .target(
            name: "ScrollKit",
            dependencies: []
        ),
        .testTarget(
            name: "ScrollKitTests",
            dependencies: ["ScrollKit"]
        ),
    ]
)
