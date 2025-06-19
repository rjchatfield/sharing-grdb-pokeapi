A local SQLite version of the PokeAPI.com database. 
- Uses https://github.com/pointfreeco/sharing-grdb for accessing SQL.
- Written in Swift 6.1 in Xcode 16.4.
- `Sources/` contains the source of the schema files and database
- `Tests/` contains the tests using `InlineSnapshotTesting` and `StructuredQueriesTestSupport`
- `submodules/` directory contains a git submodule for the original PokeAPI repo

- Build with `swift build`
- Test with `swift test`
