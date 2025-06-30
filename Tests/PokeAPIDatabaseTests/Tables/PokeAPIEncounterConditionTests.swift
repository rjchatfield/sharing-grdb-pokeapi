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
struct PokeAPIEncounterConditionTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounterCondition.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_conditions"
            """
        } results: {
            """
            ┌────┐
            │ 14 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounterCondition.limit(5)
        ) {
            """
            SELECT "encounter_conditions"."id", "encounter_conditions"."identifier"
            FROM "encounter_conditions"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEncounterCondition( │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "swarm"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterCondition( │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "time"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterCondition( │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "radar"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterCondition( │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "slot2"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterCondition( │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "radio"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}