# PokeSwift

A local SQLite version of the [PokeAPI](https://pokeapi.co) database for Swift applications, built using [sharing-grdb](https://github.com/pointfreeco/sharing-grdb) for type-safe database access.

## Overview

This package provides a complete, offline-accessible Pokemon database with all the data from PokeAPI packaged as a Swift library. Perfect for iOS and macOS apps that need Pokemon data without network dependencies.

## Features

- 🗄️ Complete PokeAPI database in SQLite format
- 🔍 Type-safe database queries using sharing-grdb
- 📱 iOS 18+ and macOS 15+ support
- ⚡ Fast, offline access to Pokemon data
- 🧪 Comprehensive test suite with snapshot testing

## Requirements

- iOS 18.0+ or macOS 15.0+
- Swift 6.1+
- Xcode 16.4+

## Installation

### Swift Package Manager

Add this package to your project by adding the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/rjchatfield/sharing-grdb-pokeapi", from: "0.1.0")
]
```

Or add it through Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select the version you want to use

## Usage

### Basic Setup

```swift
import SharingGRDBPokeAPI

// Create a database connection
let database = try PokeAPIDatabase.makeDatabase()

// Query Pokemon data
let pikachu = try database.read { db in
    try PokeAPIPokemon
        .filter(Column("identifier") == "pikachu")
        .fetchOne(db)
}
```

### Querying Pokemon

```swift
// Get all Pokemon from generation 1
let gen1Pokemon = try database.read { db in
    try PokeAPIPokemon
        .joining(required: PokeAPIPokemonSpecies.self)
        .filter(PokeAPIPokemonSpecies.Columns.generationId == 1)
        .fetchAll(db)
}

// Get Pokemon by type
let firePokemon = try database.read { db in
    try PokeAPIPokemon
        .joining(required: PokeAPIPokemonType.self)
        .joining(required: PokeAPIType.self)
        .filter(PokeAPIType.Columns.identifier == "fire")
        .fetchAll(db)
}
```

### Available Models

The package includes complete models for all PokeAPI entities:

- `PokeAPIPokemon` - Individual Pokemon forms
- `PokeAPIPokemonSpecies` - Base Pokemon species data
- `PokeAPIType` - Pokemon types (Fire, Water, etc.)
- `PokeAPIMove` - Pokemon moves
- `PokeAPIAbility` - Pokemon abilities
- `PokeAPIItem` - Items and berries
- `PokeAPILocation` - Game locations
- And many more...

## Building and Testing

```bash
# Build the package
swift build

# Run tests
swift test
```

## Data Attribution

This package contains data from the [PokeAPI](https://pokeapi.co) project. All Pokemon data is sourced from PokeAPI's comprehensive database.

**Important:** Pokemon and Pokemon character names are trademarks of Nintendo. This package is not affiliated with or endorsed by Nintendo, Game Freak, or The Pokemon Company.

## Contributing

We welcome contributions! Here's how you can help:

### Reporting Issues

- Check existing issues before creating a new one
- Include Swift version, platform, and clear reproduction steps
- For database issues, specify which Pokemon/data is affected

### Code Contributions

- Follow existing code style and patterns
- Add tests for new functionality
- Ensure all tests pass with `swift test`
- Update documentation as needed

### Data Issues

**Note:** The Pokemon data comes directly from PokeAPI. If you find incorrect Pokemon data (stats, types, etc.), please report it to the [PokeAPI project](https://github.com/PokeAPI/pokeapi) instead.

For issues with the Swift models or database schema, please create an issue here.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.

The Pokemon data is provided by PokeAPI under their license terms. Pokemon and Pokemon character names are trademarks of Nintendo.