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
struct PokeAPIAbilityTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIAbility.count()
        ) {
            """
            SELECT count(*)
            FROM "abilities"
            """
        } results: {
            """
            ┌─────┐
            │ 367 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIAbility.limit(5)
        ) {
            """
            SELECT "abilities"."id", "abilities"."identifier", "abilities"."generation_id", "abilities"."is_main_series"
            FROM "abilities"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 1),           │
            │   identifier: "stench",              │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 2),           │
            │   identifier: "drizzle",             │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 3),           │
            │   identifier: "speed-boost",         │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 4),           │
            │   identifier: "battle-armor",        │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 5),           │
            │   identifier: "sturdy",              │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}
