import Foundation
import GRDB

public enum PokeAPIDatabase {
    public static func makeDatabase() throws -> GRDB.DatabaseQueue {
        try GRDB.DatabaseQueue(
            path: bundlePath,
            configuration: defaultConfiguration
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
            guard let bundlePath = Bundle.module.path(forResource: "pokemon", ofType: "db") else {
                throw DatabaseError.bundleResourceNotFound
            }
            return bundlePath
        }
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
