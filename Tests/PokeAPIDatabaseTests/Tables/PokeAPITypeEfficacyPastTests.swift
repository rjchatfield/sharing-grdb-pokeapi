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
struct PokeAPITypeEfficacyPastTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPITypeEfficacyPast.count()
        ) {
            """
            SELECT count(*)
            FROM "type_efficacy_past"
            """
        } results: {
            """
            ┌───┐
            │ 6 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPITypeEfficacyPast.limit(5)
        ) {
            """
            SELECT "type_efficacy_past"."damage_type_id", "type_efficacy_past"."target_type_id", "type_efficacy_past"."damage_factor", "type_efficacy_past"."generation_id"
            FROM "type_efficacy_past"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPITypeEfficacyPast(              │
            │   damageTypeId: Tagged(rawValue: 4),  │
            │   targetTypeId: Tagged(rawValue: 7),  │
            │   damageFactor: 200,                  │
            │   generationId: Tagged(rawValue: 1)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPITypeEfficacyPast(              │
            │   damageTypeId: Tagged(rawValue: 7),  │
            │   targetTypeId: Tagged(rawValue: 4),  │
            │   damageFactor: 200,                  │
            │   generationId: Tagged(rawValue: 1)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPITypeEfficacyPast(              │
            │   damageTypeId: Tagged(rawValue: 8),  │
            │   targetTypeId: Tagged(rawValue: 14), │
            │   damageFactor: 0,                    │
            │   generationId: Tagged(rawValue: 1)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPITypeEfficacyPast(              │
            │   damageTypeId: Tagged(rawValue: 15), │
            │   targetTypeId: Tagged(rawValue: 10), │
            │   damageFactor: 100,                  │
            │   generationId: Tagged(rawValue: 1)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPITypeEfficacyPast(              │
            │   damageTypeId: Tagged(rawValue: 8),  │
            │   targetTypeId: Tagged(rawValue: 9),  │
            │   damageFactor: 50,                   │
            │   generationId: Tagged(rawValue: 5)   │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}