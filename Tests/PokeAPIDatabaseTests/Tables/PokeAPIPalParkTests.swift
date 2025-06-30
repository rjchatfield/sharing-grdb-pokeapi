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
struct PokeAPIPalParkTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPalPark.count()
        ) {
            """
            SELECT count(*)
            FROM "pal_park"
            """
        } results: {
            """
            ┌─────┐
            │ 493 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPalPark.limit(5)
        ) {
            """
            SELECT "pal_park"."species_id", "pal_park"."area_id", "pal_park"."base_score", "pal_park"."rate"
            FROM "pal_park"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPalPark(                   │
            │   speciesId: Tagged(rawValue: 1), │
            │   areaId: Tagged(rawValue: 2),    │
            │   baseScore: 50,                  │
            │   rate: 30                        │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPalPark(                   │
            │   speciesId: Tagged(rawValue: 2), │
            │   areaId: Tagged(rawValue: 2),    │
            │   baseScore: 80,                  │
            │   rate: 10                        │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPalPark(                   │
            │   speciesId: Tagged(rawValue: 3), │
            │   areaId: Tagged(rawValue: 2),    │
            │   baseScore: 90,                  │
            │   rate: 3                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPalPark(                   │
            │   speciesId: Tagged(rawValue: 4), │
            │   areaId: Tagged(rawValue: 2),    │
            │   baseScore: 50,                  │
            │   rate: 30                        │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPalPark(                   │
            │   speciesId: Tagged(rawValue: 5), │
            │   areaId: Tagged(rawValue: 2),    │
            │   baseScore: 80,                  │
            │   rate: 10                        │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}