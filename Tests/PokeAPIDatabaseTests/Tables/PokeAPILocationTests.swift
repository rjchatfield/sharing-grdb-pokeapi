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
struct PokeAPILocationTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPILocation.count()
        ) {
            """
            SELECT count(*)
            FROM "locations"
            """
        } results: {
            """
            ┌──────┐
            │ 1070 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPILocation.limit(5)
        ) {
            """
            SELECT "locations"."id", "locations"."identifier", "locations"."region_id"
            FROM "locations"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 1),             │
            │   identifier: "canalave-city",         │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 2),             │
            │   identifier: "eterna-city",           │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 3),             │
            │   identifier: "pastoria-city",         │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 4),             │
            │   identifier: "sunyshore-city",        │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 5),             │
            │   identifier: "sinnoh-pokemon-league", │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
}
