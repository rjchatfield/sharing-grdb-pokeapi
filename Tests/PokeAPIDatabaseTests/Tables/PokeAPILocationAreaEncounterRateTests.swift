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
struct PokeAPILocationAreaEncounterRateTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPILocationAreaEncounterRate.count()
        ) {
            """
            SELECT count(*)
            FROM "location_area_encounter_rates"
            """
        } results: {
            """
            ┌──────┐
            │ 3869 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPILocationAreaEncounterRate.limit(5)
        ) {
            """
            SELECT "location_area_encounter_rates"."location_area_id", "location_area_encounter_rates"."encounter_method_id", "location_area_encounter_rates"."version_id", "location_area_encounter_rates"."rate"
            FROM "location_area_encounter_rates"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPILocationAreaEncounterRate(         │
            │   locationAreaId: Tagged(rawValue: 1),    │
            │   encounterMethodId: Tagged(rawValue: 2), │
            │   versionId: Tagged(rawValue: 12),        │
            │   rate: 25                                │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPILocationAreaEncounterRate(         │
            │   locationAreaId: Tagged(rawValue: 1),    │
            │   encounterMethodId: Tagged(rawValue: 2), │
            │   versionId: Tagged(rawValue: 13),        │
            │   rate: 25                                │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPILocationAreaEncounterRate(         │
            │   locationAreaId: Tagged(rawValue: 1),    │
            │   encounterMethodId: Tagged(rawValue: 2), │
            │   versionId: Tagged(rawValue: 14),        │
            │   rate: 25                                │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPILocationAreaEncounterRate(         │
            │   locationAreaId: Tagged(rawValue: 1),    │
            │   encounterMethodId: Tagged(rawValue: 3), │
            │   versionId: Tagged(rawValue: 12),        │
            │   rate: 50                                │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPILocationAreaEncounterRate(         │
            │   locationAreaId: Tagged(rawValue: 1),    │
            │   encounterMethodId: Tagged(rawValue: 3), │
            │   versionId: Tagged(rawValue: 13),        │
            │   rate: 50                                │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}