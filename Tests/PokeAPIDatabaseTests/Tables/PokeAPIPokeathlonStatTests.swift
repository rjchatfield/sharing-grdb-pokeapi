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
struct PokeAPIPokeathlonStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokeathlonStat.count()
        ) {
            """
            SELECT count(*)
            FROM "pokeathlon_stats"
            """
        } results: {
            """
            ┌───┐
            │ 5 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokeathlonStat.limit(5)
        ) {
            """
            SELECT "pokeathlon_stats"."id", "pokeathlon_stats"."identifier"
            FROM "pokeathlon_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokeathlonStat(     │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "speed"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokeathlonStat(     │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "power"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokeathlonStat(     │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "skill"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokeathlonStat(     │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "stamina"    │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokeathlonStat(     │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "jump"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}