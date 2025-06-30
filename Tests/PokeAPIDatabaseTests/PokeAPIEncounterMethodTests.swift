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
struct PokeAPIEncounterMethodTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounterMethod.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_methods"
            """
        } results: {
            """
            ┌────┐
            │ 37 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounterMethod.limit(5)
        ) {
            """
            SELECT "encounter_methods"."id", "encounter_methods"."identifier", "encounter_methods"."order"
            FROM "encounter_methods"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "walk",      │
            │   order: 1                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "old-rod",   │
            │   order: 10                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "good-rod",  │
            │   order: 11                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "super-rod", │
            │   order: 12                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "surf",      │
            │   order: 14                │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
