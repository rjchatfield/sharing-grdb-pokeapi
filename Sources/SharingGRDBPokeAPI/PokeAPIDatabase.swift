import Foundation
import GRDB
import SharingGRDB
import StructuredQueries

public struct PokeAPIDatabase {
    public let dbQueue: DatabaseQueue
    
    /// Initialize the database with the bundled pokemon.db file
    public static func bundled() throws -> PokeAPIDatabase {
        try PokeAPIDatabase(
            dbQueue: databaseQueue()
        )
    }
    
    public static func databaseQueue() throws -> DatabaseQueue {
        try DatabaseQueue(
            path: bundlePath,
            configuration: defaultConfiguration
        )
    }

    private static var defaultConfiguration: Configuration {
        var config = Configuration()
        config.readonly = true
//        config.foreignKeysEnabled = true
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

private enum DatabaseError: Error, LocalizedError {
    case bundleResourceNotFound
    
    public var errorDescription: String? {
        switch self {
        case .bundleResourceNotFound:
            return "Could not find pokemon.db in bundle resources"
        }
    }
}
