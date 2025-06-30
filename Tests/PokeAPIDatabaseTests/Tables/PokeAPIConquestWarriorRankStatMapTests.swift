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
struct PokeAPIConquestWarriorRankStatMapTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorRankStatMap.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_rank_stat_map"
            """
        } results: {
            """
            ┌─────┐
            │ 968 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorRankStatMap.limit(5)
        ) {
            """
            SELECT "conquest_warrior_rank_stat_map"."warrior_rank_id", "conquest_warrior_rank_stat_map"."warrior_stat_id", "conquest_warrior_rank_stat_map"."base_stat"
            FROM "conquest_warrior_rank_stat_map"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIConquestWarriorRankStatMap(    │
            │   warriorRankId: Tagged(rawValue: 1), │
            │   warriorStatId: Tagged(rawValue: 1), │
            │   baseStat: 65                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIConquestWarriorRankStatMap(    │
            │   warriorRankId: Tagged(rawValue: 1), │
            │   warriorStatId: Tagged(rawValue: 2), │
            │   baseStat: 60                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIConquestWarriorRankStatMap(    │
            │   warriorRankId: Tagged(rawValue: 1), │
            │   warriorStatId: Tagged(rawValue: 3), │
            │   baseStat: 65                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIConquestWarriorRankStatMap(    │
            │   warriorRankId: Tagged(rawValue: 1), │
            │   warriorStatId: Tagged(rawValue: 4), │
            │   baseStat: 4                         │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIConquestWarriorRankStatMap(    │
            │   warriorRankId: Tagged(rawValue: 2), │
            │   warriorStatId: Tagged(rawValue: 1), │
            │   baseStat: 75                        │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}