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
struct PokeAPIItemFlagMapTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemFlagMap.count()
        ) {
            """
            SELECT count(*)
            FROM "item_flag_map"
            """
        } results: {
            """
            ┌─────┐
            │ 615 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItemFlagMap.limit(5)
        ) {
            """
            SELECT "item_flag_map"."item_id", "item_flag_map"."item_flag_id"
            FROM "item_flag_map"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIItemFlagMap(               │
            │   itemId: Tagged(rawValue: 1),    │
            │   itemFlagId: Tagged(rawValue: 1) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIItemFlagMap(               │
            │   itemId: Tagged(rawValue: 1),    │
            │   itemFlagId: Tagged(rawValue: 2) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIItemFlagMap(               │
            │   itemId: Tagged(rawValue: 1),    │
            │   itemFlagId: Tagged(rawValue: 4) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIItemFlagMap(               │
            │   itemId: Tagged(rawValue: 1),    │
            │   itemFlagId: Tagged(rawValue: 5) │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIItemFlagMap(               │
            │   itemId: Tagged(rawValue: 2),    │
            │   itemFlagId: Tagged(rawValue: 1) │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}