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
struct PokeAPIConquestWarriorArchetypeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorArchetype.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_archetypes"
            """
        } results: {
            """
            ┌────┐
            │ 30 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorArchetype.limit(5)
        ) {
            """
            SELECT "conquest_warrior_archetypes"."id", "conquest_warrior_archetypes"."identifier"
            FROM "conquest_warrior_archetypes"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIConquestWarriorArchetype( │
            │   id: Tagged(rawValue: 1),       │
            │   identifier: "armor-veteran"    │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarriorArchetype( │
            │   id: Tagged(rawValue: 2),       │
            │   identifier: "armor-officer"    │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarriorArchetype( │
            │   id: Tagged(rawValue: 3),       │
            │   identifier: "armor-helmet"     │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarriorArchetype( │
            │   id: Tagged(rawValue: 4),       │
            │   identifier: "armor-headlight"  │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarriorArchetype( │
            │   id: Tagged(rawValue: 5),       │
            │   identifier: "armor-sweatband"  │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
}