// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharingGRDBPokeAPI",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "SharingGRDBPokeAPI",
            targets: ["SharingGRDBPokeAPI"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/sharing-grdb", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-structured-queries", from: "0.7.0"),
    ],
    targets: [
        .target(
            name: "SharingGRDBPokeAPI",
            dependencies: [
                .product(name: "SharingGRDB", package: "sharing-grdb"),
            ],
            resources: [
                .copy("Resources/pokemon.db"),
            ]
        ),
        .testTarget(
            name: "SharingGRDBPokeAPITests",
            dependencies: [
                "SharingGRDBPokeAPI",
                .product(name: "StructuredQueries", package: "swift-structured-queries"),
                .product(name: "_StructuredQueriesSQLite", package: "swift-structured-queries"),
                .product(name: "StructuredQueriesTestSupport", package: "swift-structured-queries"),
            ]
        ),
    ],
)
