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
struct PokeAPIEncounterTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEncounter.count()
        ) {
            """
            SELECT count(*)
            FROM "encounters"
            """
        } results: {
            """
            ┌───────┐
            │ 61519 │
            └───────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEncounter.limit(5)
        ) {
            """
            SELECT "encounters"."id", "encounters"."version_id", "encounters"."location_area_id", "encounters"."encounter_slot_id", "encounters"."pokemon_id", "encounters"."min_level", "encounters"."max_level"
            FROM "encounters"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 1),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 28), │
            │   pokemonId: Tagged(rawValue: 72),       │
            │   minLevel: 20,                          │
            │   maxLevel: 30                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 2),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 29), │
            │   pokemonId: Tagged(rawValue: 278),      │
            │   minLevel: 20,                          │
            │   maxLevel: 30                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 3),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 30), │
            │   pokemonId: Tagged(rawValue: 73),       │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 4),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 31), │
            │   pokemonId: Tagged(rawValue: 279),      │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 5),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 32), │
            │   pokemonId: Tagged(rawValue: 279),      │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}
