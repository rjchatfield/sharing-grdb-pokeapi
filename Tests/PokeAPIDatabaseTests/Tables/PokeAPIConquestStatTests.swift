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
struct PokeAPIConquestStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestStat.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_stats"
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
            PokeAPIConquestStat.limit(5)
        ) {
            """
            SELECT "conquest_stats"."id", "conquest_stats"."identifier", "conquest_stats"."is_base"
            FROM "conquest_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIConquestStat(       │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "hp",        │
            │   isBase: true             │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestStat(       │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "attack",    │
            │   isBase: true             │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestStat(       │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "defense",   │
            │   isBase: true             │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestStat(       │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "speed",     │
            │   isBase: true             │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestStat(       │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "range",     │
            │   isBase: false            │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}