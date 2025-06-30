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
struct PokeAPIConquestWarriorSkillTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorSkill.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_skills"
            """
        } results: {
            """
            ┌────┐
            │ 63 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorSkill.limit(5)
        ) {
            """
            SELECT "conquest_warrior_skills"."id", "conquest_warrior_skills"."identifier"
            FROM "conquest_warrior_skills"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────┐
            │ PokeAPIConquestWarriorSkill( │
            │   id: Tagged(rawValue: 1),   │
            │   identifier: "adrenaline"   │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIConquestWarriorSkill( │
            │   id: Tagged(rawValue: 2),   │
            │   identifier: "fortify"      │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIConquestWarriorSkill( │
            │   id: Tagged(rawValue: 3),   │
            │   identifier: "top-speed"    │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIConquestWarriorSkill( │
            │   id: Tagged(rawValue: 4),   │
            │   identifier: "rally"        │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIConquestWarriorSkill( │
            │   id: Tagged(rawValue: 5),   │
            │   identifier: "bustle"       │
            │ )                            │
            └──────────────────────────────┘
            """
        }
    }
}