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
struct PokeAPINaturePokeathlonStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPINaturePokeathlonStat.count()
        ) {
            """
            SELECT count(*)
            FROM "nature_pokeathlon_stats"
            """
        } results: {
            """
            ┌────┐
            │ 50 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPINaturePokeathlonStat.limit(5)
        ) {
            """
            SELECT "nature_pokeathlon_stats"."nature_id", "nature_pokeathlon_stats"."pokeathlon_stat_id", "nature_pokeathlon_stats"."max_change"
            FROM "nature_pokeathlon_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPINaturePokeathlonStat(             │
            │   natureId: Tagged(rawValue: 1),         │
            │   pokeathlonStatId: Tagged(rawValue: 1), │
            │   maxChange: -1                          │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPINaturePokeathlonStat(             │
            │   natureId: Tagged(rawValue: 1),         │
            │   pokeathlonStatId: Tagged(rawValue: 2), │
            │   maxChange: 1                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPINaturePokeathlonStat(             │
            │   natureId: Tagged(rawValue: 2),         │
            │   pokeathlonStatId: Tagged(rawValue: 1), │
            │   maxChange: -2                          │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPINaturePokeathlonStat(             │
            │   natureId: Tagged(rawValue: 2),         │
            │   pokeathlonStatId: Tagged(rawValue: 3), │
            │   maxChange: 2                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPINaturePokeathlonStat(             │
            │   natureId: Tagged(rawValue: 3),         │
            │   pokeathlonStatId: Tagged(rawValue: 1), │
            │   maxChange: -2                          │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}