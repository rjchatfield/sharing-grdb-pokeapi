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
struct PokeAPIMoveFlagTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveFlag.count()
        ) {
            """
            SELECT count(*)
            FROM "move_flags"
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
            PokeAPIMoveFlag.limit(5)
        ) {
            """
            SELECT "move_flags"."id", "move_flags"."identifier"
            FROM "move_flags"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────┐
            │ PokeAPIMoveFlag(            │
            │   id: Tagged(rawValue: 1),  │
            │   identifier: "contact"     │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveFlag(            │
            │   id: Tagged(rawValue: 2),  │
            │   identifier: "charge"      │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveFlag(            │
            │   id: Tagged(rawValue: 3),  │
            │   identifier: "recharge"    │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveFlag(            │
            │   id: Tagged(rawValue: 4),  │
            │   identifier: "protect"     │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIMoveFlag(            │
            │   id: Tagged(rawValue: 5),  │
            │   identifier: "reflectable" │
            │ )                           │
            └─────────────────────────────┘
            """
        }
    }
}