A local SQLite version of the PokeAPI.com database. 
- SQLite file located in /Sources/PokeAPIDatabase/Resources/pokemon.db
- SQLite file was populated by the CSV files in /submodules/pokeapi/data/v2/csv
- Uses https://github.com/pointfreeco/swift-structured-queries for accessing SQL.
- Written in Swift 6.1 in Xcode 16.4.
- `Sources/` contains the source of the schema files and database
- `Tests/` contains the tests using `InlineSnapshotTesting` and `StructuredQueriesTestSupport`
- `submodules/` directory contains a git submodule for the original PokeAPI repo

- Build with `swift build`
- Test with `swift test`
- If test involves an inline snapshot test, it will not record an update. You will need me to run it.