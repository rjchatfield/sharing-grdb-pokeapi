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
struct PokeAPIConquestEpisodeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestEpisode.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_episodes"
            """
        } results: {
            """
            ┌────┐
            │ 38 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestEpisode.limit(5)
        ) {
            """
            SELECT "conquest_episodes"."id", "conquest_episodes"."identifier"
            FROM "conquest_episodes"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPIConquestEpisode(                │
            │   id: Tagged(rawValue: 1),             │
            │   identifier: "the-legend-of-ransei"   │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIConquestEpisode(                │
            │   id: Tagged(rawValue: 2),             │
            │   identifier: "the-road-to-conquest"   │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIConquestEpisode(                │
            │   id: Tagged(rawValue: 3),             │
            │   identifier: "happily-ever-after"     │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIConquestEpisode(                │
            │   id: Tagged(rawValue: 4),             │
            │   identifier: "the-burden-of-peace"    │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIConquestEpisode(                │
            │   id: Tagged(rawValue: 5),             │
            │   identifier: "the-way-of-the-warrior" │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
}