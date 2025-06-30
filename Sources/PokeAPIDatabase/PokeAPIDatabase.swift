import Foundation
import GRDB
import StructuredQueriesSQLite

public enum PokeAPIDatabase {
    public static func makeGRDBDatabase() throws -> GRDB.DatabaseQueue {
        try GRDB.DatabaseQueue(
            path: bundlePath,
            configuration: defaultConfiguration
        )
    }

    public static func makeSQLDatabase() throws -> StructuredQueriesSQLite.Database {
        try StructuredQueriesSQLite.Database(
            path: PokeAPIDatabase.bundlePath
        )
    }

    // MARK: -

    private static var defaultConfiguration: GRDB.Configuration {
        var config = GRDB.Configuration()
        config.readonly = true
        return config
    }

    private static var bundlePath: String {
        get throws {
            guard let bundlePath = Bundle.pokeapi.path(forResource: "pokeapi", ofType: "db") else {
                throw DatabaseError.bundleResourceNotFound
            }
            return bundlePath
        }
    }
}

extension Bundle {
    public static var pokeapi: Bundle {
        return .module
    }
}

// MARK: -

private enum DatabaseError: Error, LocalizedError {
    case bundleResourceNotFound
    
    public var errorDescription: String? {
        switch self {
        case .bundleResourceNotFound:
            return "Could not find pokemon.db in bundle resources"
        }
    }
}
