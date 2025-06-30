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
struct PokeAPIConquestWarriorTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarrior.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warriors"
            """
        } results: {
            """
            ┌─────┐
            │ 201 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarrior.limit(5)
        ) {
            """
            SELECT "conquest_warriors"."id", "conquest_warriors"."identifier", "conquest_warriors"."gender_id", "conquest_warriors"."archetype_id"
            FROM "conquest_warriors"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIConquestWarrior(          │
            │   id: Tagged(rawValue: 1),       │
            │   identifier: "player-m",        │
            │   genderId: Tagged(rawValue: 2), │
            │   archetypeId: nil               │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarrior(          │
            │   id: Tagged(rawValue: 2),       │
            │   identifier: "player-f",        │
            │   genderId: Tagged(rawValue: 1), │
            │   archetypeId: nil               │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarrior(          │
            │   id: Tagged(rawValue: 3),       │
            │   identifier: "nobunaga",        │
            │   genderId: Tagged(rawValue: 2), │
            │   archetypeId: nil               │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarrior(          │
            │   id: Tagged(rawValue: 4),       │
            │   identifier: "oichi",           │
            │   genderId: Tagged(rawValue: 1), │
            │   archetypeId: nil               │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIConquestWarrior(          │
            │   id: Tagged(rawValue: 5),       │
            │   identifier: "hideyoshi",       │
            │   genderId: Tagged(rawValue: 2), │
            │   archetypeId: nil               │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
}
