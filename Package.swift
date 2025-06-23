// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokeAPIDatabase",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7),
    ],
    products: [
        .library(
            name: "PokeAPIDatabase",
            targets: ["PokeAPIDatabase"],
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-structured-queries",
            from: "0.7.0",
            traits: [
                "StructuredQueriesTagged",
            ]
        ),
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
        .package(url: "https://github.com/groue/GRDB.swift", from: "7.4.0"),
    ],
    targets: [
        .target(
            name: "PokeAPIDatabase",
            dependencies: [
                .product(name: "StructuredQueries", package: "swift-structured-queries"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "GRDB", package: "GRDB.swift"),
            ],
            resources: [
                .copy("Resources/pokemon.db"),
                .process("Resources/Strings"),
            ]
        ),
        .testTarget(
            name: "PokeAPIDatabaseTests",
            dependencies: [
                "PokeAPIDatabase",
                .product(name: "StructuredQueries", package: "swift-structured-queries"),
                .product(name: "_StructuredQueriesSQLite", package: "swift-structured-queries"),
                .product(name: "StructuredQueriesTestSupport", package: "swift-structured-queries"),
            ]
        ),
    ],
)
