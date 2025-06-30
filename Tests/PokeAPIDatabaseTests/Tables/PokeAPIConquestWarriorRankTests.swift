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
struct PokeAPIConquestWarriorRankTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorRank.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_ranks"
            """
        } results: {
            """
            ┌─────┐
            │ 242 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorRank.limit(5)
        ) {
            """
            SELECT "conquest_warrior_ranks"."id", "conquest_warrior_ranks"."warrior_id", "conquest_warrior_ranks"."rank", "conquest_warrior_ranks"."skill_id"
            FROM "conquest_warrior_ranks"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestWarriorRank(       │
            │   id: Tagged(rawValue: 1),        │
            │   warriorId: Tagged(rawValue: 1), │
            │   rank: 1,                        │
            │   skillId: Tagged(rawValue: 3)    │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorRank(       │
            │   id: Tagged(rawValue: 2),        │
            │   warriorId: Tagged(rawValue: 1), │
            │   rank: 2,                        │
            │   skillId: Tagged(rawValue: 24)   │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorRank(       │
            │   id: Tagged(rawValue: 3),        │
            │   warriorId: Tagged(rawValue: 1), │
            │   rank: 3,                        │
            │   skillId: Tagged(rawValue: 25)   │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorRank(       │
            │   id: Tagged(rawValue: 4),        │
            │   warriorId: Tagged(rawValue: 2), │
            │   rank: 1,                        │
            │   skillId: Tagged(rawValue: 3)    │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorRank(       │
            │   id: Tagged(rawValue: 5),        │
            │   warriorId: Tagged(rawValue: 2), │
            │   rank: 2,                        │
            │   skillId: Tagged(rawValue: 24)   │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}