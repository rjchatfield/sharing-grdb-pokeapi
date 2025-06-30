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
struct PokeAPIEncounterConditionValueTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounterConditionValue.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_condition_values"
            """
        } results: {
            """
            ┌─────┐
            │ 105 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounterConditionValue.limit(5)
        ) {
            """
            SELECT "encounter_condition_values"."id", "encounter_condition_values"."encounter_condition_id", "encounter_condition_values"."identifier", "encounter_condition_values"."is_default"
            FROM "encounter_condition_values"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────────┐
            │ PokeAPIEncounterConditionValue(              │
            │   id: Tagged(rawValue: 1),                   │
            │   encounterConditionId: Tagged(rawValue: 1), │
            │   identifier: "swarm-yes",                   │
            │   isDefault: 0                               │
            │ )                                            │
            ├──────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValue(              │
            │   id: Tagged(rawValue: 2),                   │
            │   encounterConditionId: Tagged(rawValue: 1), │
            │   identifier: "swarm-no",                    │
            │   isDefault: 1                               │
            │ )                                            │
            ├──────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValue(              │
            │   id: Tagged(rawValue: 3),                   │
            │   encounterConditionId: Tagged(rawValue: 2), │
            │   identifier: "time-morning",                │
            │   isDefault: 0                               │
            │ )                                            │
            ├──────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValue(              │
            │   id: Tagged(rawValue: 4),                   │
            │   encounterConditionId: Tagged(rawValue: 2), │
            │   identifier: "time-day",                    │
            │   isDefault: 1                               │
            │ )                                            │
            ├──────────────────────────────────────────────┤
            │ PokeAPIEncounterConditionValue(              │
            │   id: Tagged(rawValue: 5),                   │
            │   encounterConditionId: Tagged(rawValue: 2), │
            │   identifier: "time-night",                  │
            │   isDefault: 0                               │
            │ )                                            │
            └──────────────────────────────────────────────┘
            """
        }
    }
}