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
struct PokeAPIMoveTargetTests {
    @Test
        func testMoveTargetBasicQuery() {
            Helper.assertQuery(
                PokeAPIMoveTarget.count()
            ) {
                """
                SELECT count(*)
                FROM "move_targets"
                """
            } results: {
                """
                ┌────┐
                │ 16 │
                └────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIMoveTarget.limit(5)
            ) {
                """
                SELECT "move_targets"."id", "move_targets"."identifier"
                FROM "move_targets"
                LIMIT 5
                """
            } results: {
                """
                ┌───────────────────────────────────────────┐
                │ PokeAPIMoveTarget(                        │
                │   id: Tagged(rawValue: 1),                │
                │   identifier: "specific-move"             │
                │ )                                         │
                ├───────────────────────────────────────────┤
                │ PokeAPIMoveTarget(                        │
                │   id: Tagged(rawValue: 2),                │
                │   identifier: "selected-pokemon-me-first" │
                │ )                                         │
                ├───────────────────────────────────────────┤
                │ PokeAPIMoveTarget(                        │
                │   id: Tagged(rawValue: 3),                │
                │   identifier: "ally"                      │
                │ )                                         │
                ├───────────────────────────────────────────┤
                │ PokeAPIMoveTarget(                        │
                │   id: Tagged(rawValue: 4),                │
                │   identifier: "users-field"               │
                │ )                                         │
                ├───────────────────────────────────────────┤
                │ PokeAPIMoveTarget(                        │
                │   id: Tagged(rawValue: 5),                │
                │   identifier: "user-or-ally"              │
                │ )                                         │
                └───────────────────────────────────────────┘
                """
            }
        }
}
