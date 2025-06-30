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
struct PokeAPIBerryFlavorTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIBerryFlavor.count()
        ) {
            """
            SELECT count(*)
            FROM "berry_flavors"
            """
        } results: {
            """
            ┌─────┐
            │ 320 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIBerryFlavor.limit(5)
        ) {
            """
            SELECT "berry_flavors"."berry_id", "berry_flavors"."contest_type_id", "berry_flavors"."flavor"
            FROM "berry_flavors"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIBerryFlavor(                   │
            │   berryId: Tagged(rawValue: 1),       │
            │   contestTypeId: Tagged(rawValue: 1), │
            │   flavor: 10                          │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIBerryFlavor(                   │
            │   berryId: Tagged(rawValue: 1),       │
            │   contestTypeId: Tagged(rawValue: 2), │
            │   flavor: 0                           │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIBerryFlavor(                   │
            │   berryId: Tagged(rawValue: 1),       │
            │   contestTypeId: Tagged(rawValue: 3), │
            │   flavor: 0                           │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIBerryFlavor(                   │
            │   berryId: Tagged(rawValue: 1),       │
            │   contestTypeId: Tagged(rawValue: 4), │
            │   flavor: 0                           │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIBerryFlavor(                   │
            │   berryId: Tagged(rawValue: 1),       │
            │   contestTypeId: Tagged(rawValue: 5), │
            │   flavor: 0                           │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}