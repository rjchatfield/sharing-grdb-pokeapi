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
struct PokeAPIConquestWarriorStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorStat.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_stats"
            """
        } results: {
            """
            ┌───┐
            │ 4 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorStat.limit(5)
        ) {
            """
            SELECT "conquest_warrior_stats"."id", "conquest_warrior_stats"."identifier"
            FROM "conquest_warrior_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────┐
            │ PokeAPIConquestWarriorStat( │
            │   id: Tagged(rawValue: 1),  │
            │   identifier: "power"       │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIConquestWarriorStat( │
            │   id: Tagged(rawValue: 2),  │
            │   identifier: "wisdom"      │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIConquestWarriorStat( │
            │   id: Tagged(rawValue: 3),  │
            │   identifier: "charisma"    │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIConquestWarriorStat( │
            │   id: Tagged(rawValue: 4),  │
            │   identifier: "capacity"    │
            │ )                           │
            └─────────────────────────────┘
            """
        }
    }
}