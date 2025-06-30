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
struct PokeAPIEncounterConditionValueMapTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounterConditionValueMap.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_condition_value_map"
            """
        } results: {
            """
            ┌───────┐
            │ 17935 │
            └───────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounterConditionValueMap.limit(5)
        ) {
            """
            SELECT "encounter_condition_value_map"."encounter_id", "encounter_condition_value_map"."encounter_condition_value_id"
            FROM "encounter_condition_value_map"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────────────┐
            │ PokeAPIEncounterConditionValueMap(               │
            │   encounterId: Tagged(rawValue: 125),            │
            │   encounterConditionValueId: Tagged(rawValue: 2) │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValueMap(               │
            │   encounterId: Tagged(rawValue: 126),            │
            │   encounterConditionValueId: Tagged(rawValue: 1) │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValueMap(               │
            │   encounterId: Tagged(rawValue: 127),            │
            │   encounterConditionValueId: Tagged(rawValue: 2) │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValueMap(               │
            │   encounterId: Tagged(rawValue: 128),            │
            │   encounterConditionValueId: Tagged(rawValue: 1) │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValueMap(               │
            │   encounterId: Tagged(rawValue: 131),            │
            │   encounterConditionValueId: Tagged(rawValue: 7) │
            │ )                                                │
            └──────────────────────────────────────────────────┘
            """
        }
    }
}