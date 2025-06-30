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
struct PokeAPIItemCategoryTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemCategory.count()
        ) {
            """
            SELECT count(*)
            FROM "item_categories"
            """
        } results: {
            """
            ┌────┐
            │ 54 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItemCategory.limit(5)
        ) {
            """
            SELECT "item_categories"."id", "item_categories"."identifier", "item_categories"."pocket_id"
            FROM "item_categories"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────┐
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 1),   │
            │   identifier: "stat-boosts", │
            │   pocketId: 7                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 2),   │
            │   identifier: "effort-drop", │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 3),   │
            │   identifier: "medicine",    │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 4),   │
            │   identifier: "other",       │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 5),   │
            │   identifier: "in-a-pinch",  │
            │   pocketId: 5                │
            │ )                            │
            └──────────────────────────────┘
            """
        }
    }
}
