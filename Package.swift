// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Neo4jData",
    products: [
        .library(name: "Neo4jDataCore", targets: ["Neo4jDataCore"]),
        .executable(name: "Neo4jData", targets: ["Neo4jData"])
    ],
    dependencies: [
        .package(url: "https://github.com/Neo4j-Swift/Neo4j-Swift.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "Neo4jDataCore",
            dependencies: ["Theo"]),
        .target(
            name: "Neo4jData",
            dependencies: ["Neo4jDataCore"]),
        .testTarget(
            name: "Neo4jDataTests",
            dependencies: ["Neo4jDataCore"]),
    ]
)
