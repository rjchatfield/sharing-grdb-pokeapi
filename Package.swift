// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharingGRDBPokeAPI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7),
    ],
    products: [
        .library(
            name: "SharingGRDBPokeAPI",
            targets: ["SharingGRDBPokeAPI"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-structured-queries", from: "0.7.0"),
        .package(url: "https://github.com/groue/GRDB.swift", from: "6.0.0"),
    ],
    targets: [
        .target(
            name: "SharingGRDBPokeAPI",
            dependencies: [
                .product(name: "StructuredQueries", package: "swift-structured-queries"),
                .product(name: "GRDB", package: "GRDB.swift"),
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
