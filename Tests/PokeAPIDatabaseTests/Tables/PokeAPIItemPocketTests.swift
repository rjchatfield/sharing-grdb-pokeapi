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
struct PokeAPIItemPocketTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemPocket.count()
        ) {
            """
            SELECT count(*)
            FROM "item_pockets"
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
            PokeAPIItemPocket.limit(5)
        ) {
            """
            SELECT "item_pockets"."id", "item_pockets"."identifier"
            FROM "item_pockets"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIItemPocket(         │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "misc"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIItemPocket(         │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "medicine"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIItemPocket(         │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "pokeballs"  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIItemPocket(         │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "machines"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIItemPocket(         │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "berries"    │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}