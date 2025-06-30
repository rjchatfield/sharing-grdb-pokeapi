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
struct PokeAPIConquestEpisodeWarriorTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestEpisodeWarrior.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_episode_warriors"
            """
        } results: {
            """
            ┌────┐
            │ 40 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestEpisodeWarrior.limit(5)
        ) {
            """
            SELECT "conquest_episode_warriors"."episode_id", "conquest_episode_warriors"."warrior_id"
            FROM "conquest_episode_warriors"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestEpisodeWarrior(    │
            │   episodeId: Tagged(rawValue: 1), │
            │   warriorId: Tagged(rawValue: 1)  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestEpisodeWarrior(    │
            │   episodeId: Tagged(rawValue: 1), │
            │   warriorId: Tagged(rawValue: 2)  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestEpisodeWarrior(    │
            │   episodeId: Tagged(rawValue: 2), │
            │   warriorId: Tagged(rawValue: 3)  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestEpisodeWarrior(    │
            │   episodeId: Tagged(rawValue: 3), │
            │   warriorId: Tagged(rawValue: 5)  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestEpisodeWarrior(    │
            │   episodeId: Tagged(rawValue: 4), │
            │   warriorId: Tagged(rawValue: 19) │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}