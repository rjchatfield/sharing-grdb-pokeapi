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
struct PokeAPIMoveMetaCategoryTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveMetaCategory.count()
        ) {
            """
            SELECT count(*)
            FROM "move_meta_categories"
            """
        } results: {
            """
            ┌────┐
            │ 14 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveMetaCategory.limit(5)
        ) {
            """
            SELECT "move_meta_categories"."id", "move_meta_categories"."identifier"
            FROM "move_meta_categories"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────┐
            │ PokeAPIMoveMetaCategory(       │
            │   id: Tagged(rawValue: 0),     │
            │   identifier: "damage"         │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIMoveMetaCategory(       │
            │   id: Tagged(rawValue: 1),     │
            │   identifier: "ailment"        │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIMoveMetaCategory(       │
            │   id: Tagged(rawValue: 2),     │
            │   identifier: "net-good-stats" │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIMoveMetaCategory(       │
            │   id: Tagged(rawValue: 3),     │
            │   identifier: "heal"           │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIMoveMetaCategory(       │
            │   id: Tagged(rawValue: 4),     │
            │   identifier: "damage+ailment" │
            │ )                              │
            └────────────────────────────────┘
            """
        }
    }
}