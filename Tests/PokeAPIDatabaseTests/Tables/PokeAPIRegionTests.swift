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
struct PokeAPIRegionTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIRegion.count()
        ) {
            """
            SELECT count(*)
            FROM "regions"
            """
        } results: {
            """
            ┌────┐
            │ 10 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIRegion.limit(5)
        ) {
            """
            SELECT "regions"."id", "regions"."identifier"
            FROM "regions"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "kanto"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "johto"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "hoenn"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "sinnoh"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "unova"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
