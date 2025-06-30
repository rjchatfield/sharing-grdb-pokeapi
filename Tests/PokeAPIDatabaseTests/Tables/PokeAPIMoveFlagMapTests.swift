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
struct PokeAPIMoveFlagMapTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveFlagMap.count()
        ) {
            """
            SELECT count(*)
            FROM "move_flag_map"
            """
        } results: {
            """
            ┌──────┐
            │ 1969 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveFlagMap.limit(5)
        ) {
            """
            SELECT "move_flag_map"."move_id", "move_flag_map"."move_flag_id"
            FROM "move_flag_map"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIMoveFlagMap(               │
            │   moveId: Tagged(rawValue: 1),    │
            │   moveFlagId: Tagged(rawValue: 1) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIMoveFlagMap(               │
            │   moveId: Tagged(rawValue: 1),    │
            │   moveFlagId: Tagged(rawValue: 4) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIMoveFlagMap(               │
            │   moveId: Tagged(rawValue: 1),    │
            │   moveFlagId: Tagged(rawValue: 7) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIMoveFlagMap(               │
            │   moveId: Tagged(rawValue: 2),    │
            │   moveFlagId: Tagged(rawValue: 1) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIMoveFlagMap(               │
            │   moveId: Tagged(rawValue: 2),    │
            │   moveFlagId: Tagged(rawValue: 4) │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}