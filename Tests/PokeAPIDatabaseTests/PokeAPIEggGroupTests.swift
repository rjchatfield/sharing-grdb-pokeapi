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
struct PokeAPIEggGroupTests {
    @Test
        func testEggGroupBasicQuery() {
            Helper.assertQuery(
                PokeAPIEggGroup.count()
            ) {
                """
                SELECT count(*)
                FROM "egg_groups"
                """
            } results: {
                """
                ┌────┐
                │ 15 │
                └────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIEggGroup.limit(5)
            ) {
                """
                SELECT "egg_groups"."id", "egg_groups"."identifier"
                FROM "egg_groups"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────┐
                │ PokeAPIEggGroup(           │
                │   id: Tagged(rawValue: 1), │
                │   identifier: "monster"    │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEggGroup(           │
                │   id: Tagged(rawValue: 2), │
                │   identifier: "water1"     │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEggGroup(           │
                │   id: Tagged(rawValue: 3), │
                │   identifier: "bug"        │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEggGroup(           │
                │   id: Tagged(rawValue: 4), │
                │   identifier: "flying"     │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIEggGroup(           │
                │   id: Tagged(rawValue: 5), │
                │   identifier: "ground"     │
                │ )                          │
                └────────────────────────────┘
                """
            }
        }
}
