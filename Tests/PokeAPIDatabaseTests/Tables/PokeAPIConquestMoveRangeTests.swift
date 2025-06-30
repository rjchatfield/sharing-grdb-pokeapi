import Testing
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIConquestMoveRangeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestMoveRange.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_move_ranges"
            """
        } results: {
            """
            ┌────┐
            │ 21 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestMoveRange.limit(5)
        ) {
            """
            SELECT "conquest_move_ranges"."id", "conquest_move_ranges"."identifier", "conquest_move_ranges"."targets"
            FROM "conquest_move_ranges"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestMoveRange(         │
            │   id: Tagged(rawValue: 1),        │
            │   identifier: "user",             │
            │   targets: 1                      │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveRange(         │
            │   id: Tagged(rawValue: 2),        │
            │   identifier: "tile-1-ahead",     │
            │   targets: 1                      │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveRange(         │
            │   id: Tagged(rawValue: 3),        │
            │   identifier: "column-2-tiles",   │
            │   targets: 2                      │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveRange(         │
            │   id: Tagged(rawValue: 4),        │
            │   identifier: "column-3-tiles",   │
            │   targets: 3                      │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveRange(         │
            │   id: Tagged(rawValue: 5),        │
            │   identifier: "diamond-adjacent", │
            │   targets: 4                      │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}