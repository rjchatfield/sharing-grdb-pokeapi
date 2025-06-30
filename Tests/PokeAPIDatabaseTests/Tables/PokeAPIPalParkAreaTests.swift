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
struct PokeAPIPalParkAreaTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPalParkArea.count()
        ) {
            """
            SELECT count(*)
            FROM "pal_park_areas"
            """
        } results: {
            """
            ┌───┐
            │ 5 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPalParkArea.limit(5)
        ) {
            """
            SELECT "pal_park_areas"."id", "pal_park_areas"."identifier"
            FROM "pal_park_areas"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPalParkArea(        │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "forest"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPalParkArea(        │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "field"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPalParkArea(        │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "mountain"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPalParkArea(        │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "pond"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPalParkArea(        │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "sea"        │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}