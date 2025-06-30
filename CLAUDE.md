A local SQLite version of the PokeAPI.com database. 
- SQLite file located in /Sources/PokeAPIDatabase/Resources/pokeapi.db
- SQLite file was populated by the CSV files in /submodules/pokeapi/data/v2/csv
- Uses https://github.com/pointfreeco/swift-structured-queries for accessing SQL.
- Written in Swift 6.1 in Xcode 16.4.
- `Sources/` contains the source of the schema files and database
- `Tests/` contains the tests using `InlineSnapshotTesting` and `StructuredQueriesTestSupport`
- `submodules/` directory contains a git submodule for the original PokeAPI repo

- Build with `swift build` (grep for errors: `swift build 2>&1 | grep -i error`)
- Test with `swift test` (grep for errors: `swift test 2>&1 | grep -E "(error|fail)"`)
- Update database with latest CSV data: `./scripts/update_database.sh`
- To save tokens, filter output for errors/failures when running commands for Claude
- **Recording inline snapshots**: `swift test` cannot record inline snapshots properly. Use `xcodebuild` instead:
  ```bash
  xcodebuild test -scheme PokeAPIDatabase -destination "platform=macOS,arch=arm64"
  ```
  This will automatically update source files with recorded snapshots when tests fail due to snapshot mismatches.
