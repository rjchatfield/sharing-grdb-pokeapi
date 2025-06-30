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
struct PokeAPIItemFlagTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemFlag.count()
        ) {
            """
            SELECT count(*)
            FROM "item_flags"
            """
        } results: {
            """
            ┌───┐
            │ 8 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItemFlag.limit(5)
        ) {
            """
            SELECT "item_flags"."id", "item_flags"."identifier"
            FROM "item_flags"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIItemFlag(                 │
            │   id: Tagged(rawValue: 1),       │
            │   identifier: "countable"        │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIItemFlag(                 │
            │   id: Tagged(rawValue: 2),       │
            │   identifier: "consumable"       │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIItemFlag(                 │
            │   id: Tagged(rawValue: 3),       │
            │   identifier: "usable-overworld" │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIItemFlag(                 │
            │   id: Tagged(rawValue: 4),       │
            │   identifier: "usable-in-battle" │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIItemFlag(                 │
            │   id: Tagged(rawValue: 5),       │
            │   identifier: "holdable"         │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
}