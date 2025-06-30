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
struct PokeAPIEvolutionTriggerTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIEvolutionTrigger.count()
        ) {
            """
            SELECT count(*)
            FROM "evolution_triggers"
            """
        } results: {
            """
            ┌────┐
            │ 13 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIEvolutionTrigger.limit(5)
        ) {
            """
            SELECT "evolution_triggers"."id", "evolution_triggers"."identifier"
            FROM "evolution_triggers"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "level-up"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "trade"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "use-item"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "shed"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "spin"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
