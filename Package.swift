// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CwlDemangle",
    products: [
        .library(name: "CwlDemangle", targets: ["CwlDemangle"]),
        .executable(name: "demangle", targets: ["CwlDemangleTool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "CwlDemangle",
            path: "CwlDemangle",
            exclude: ["main.swift"],
            sources: ["CwlDemangle.swift", "CwlDemangle+JSON.swift"]
        ),
        .target(
            name: "CwlDemangleTool",
            dependencies: [
                "CwlDemangle",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "CwlDemangle",
            sources: ["main.swift"],
            resources: [.copy("manglings.txt")]
        ),
        .testTarget(
            name: "CwlDemangleTests",
            dependencies: ["CwlDemangle"],
            path: "CwlDemangleTests"
        ),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
