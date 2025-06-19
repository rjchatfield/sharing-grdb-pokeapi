import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
@testable import SharingGRDBPokeAPI

enum Helper {
    static func assertQuery<S: StructuredQueries.SelectStatement, each J: StructuredQueries.Table>(
        _ query: S,
        sql: (() -> String)? = nil,
        results: (() -> String)? = nil,
        fileID: StaticString = #fileID,
        filePath: StaticString = #filePath,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) where S.QueryValue == (), S.Joins == (repeat each J) {
        StructuredQueriesTestSupport.assertQuery(
            query,
            execute: db.execute,
            sql: sql,
            results: results,
            snapshotTrailingClosureOffset: 0,
            fileID: fileID,
            filePath: filePath,
            function: function,
            line: line,
            column: column
        )
    }
    
    static func assertQuery<each V: StructuredQueries.QueryRepresentable>(
        _ query: some StructuredQueries.Statement<(repeat each V)>,
        sql: (() -> String)? = nil,
        results: (() -> String)? = nil,
        fileID: StaticString = #fileID,
        filePath: StaticString = #filePath,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        StructuredQueriesTestSupport.assertQuery(
            query,
            execute: db.execute,
            sql: sql,
            results: results,
            snapshotTrailingClosureOffset: 0,
            fileID: fileID,
            filePath: filePath,
            function: function,
            line: line,
            column: column
        )
    }
    
    private static var db: StructuredQueriesSQLite.Database {
        let repo = try! PokeAPIDatabase.bundled()
        return try! Database(path: repo.dbQueue.path)
    }
}

// MARK: -

extension StructuredQueriesSQLite.Database: @unchecked @retroactive Sendable {}
