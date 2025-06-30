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
struct PokeAPITypeEfficacyTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPITypeEfficacy.count()
        ) {
            """
            SELECT count(*)
            FROM "type_efficacy"
            """
        } results: {
            """
            ┌─────┐
            │ 324 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPITypeEfficacy.limit(5)
        ) {
            """
            SELECT "type_efficacy"."damage_type_id", "type_efficacy"."target_type_id", "type_efficacy"."damage_factor"
            FROM "type_efficacy"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 1), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 2), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 3), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 4), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 5), │
            │   damageFactor: 100                  │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}
