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
struct PokeAPIEncounterSlotTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounterSlot.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_slots"
            """
        } results: {
            """
            ┌──────┐
            │ 1140 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounterSlot.limit(5)
        ) {
            """
            SELECT "encounter_slots"."id", "encounter_slots"."version_group_id", "encounter_slots"."encounter_method_id", "encounter_slots"."slot", "encounter_slots"."rarity"
            FROM "encounter_slots"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 1),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 1,                                │
            │   rarity: 20                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 2),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 2,                                │
            │   rarity: 20                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 3),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 3,                                │
            │   rarity: 10                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 4),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 4,                                │
            │   rarity: 10                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 5),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 5,                                │
            │   rarity: 10                              │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}
