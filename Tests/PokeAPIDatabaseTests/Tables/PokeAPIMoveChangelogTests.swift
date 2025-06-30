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
struct PokeAPIMoveChangelogTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveChangelog.count()
        ) {
            """
            SELECT count(*)
            FROM "move_changelog"
            """
        } results: {
            """
            ┌─────┐
            │ 197 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveChangelog.limit(5)
        ) {
            """
            SELECT "move_changelog"."move_id", "move_changelog"."changed_in_version_group_id", "move_changelog"."type_id", "move_changelog"."power", "move_changelog"."pp", "move_changelog"."accuracy", "move_changelog"."priority", "move_changelog"."target_id", "move_changelog"."effect_id", "move_changelog"."effect_chance"
            FROM "move_changelog"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────────────┐
            │ PokeAPIMoveChangelog(                            │
            │   moveId: Tagged(rawValue: 2),                   │
            │   changedInVersionGroupId: Tagged(rawValue: 3),  │
            │   typeId: Tagged(rawValue: 1),                   │
            │   power: nil,                                    │
            │   pp: nil,                                       │
            │   accuracy: nil,                                 │
            │   priority: nil,                                 │
            │   targetId: nil,                                 │
            │   effectId: nil,                                 │
            │   effectChance: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIMoveChangelog(                            │
            │   moveId: Tagged(rawValue: 13),                  │
            │   changedInVersionGroupId: Tagged(rawValue: 5),  │
            │   typeId: nil,                                   │
            │   power: nil,                                    │
            │   pp: nil,                                       │
            │   accuracy: 75,                                  │
            │   priority: nil,                                 │
            │   targetId: nil,                                 │
            │   effectId: nil,                                 │
            │   effectChance: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIMoveChangelog(                            │
            │   moveId: Tagged(rawValue: 14),                  │
            │   changedInVersionGroupId: Tagged(rawValue: 15), │
            │   typeId: nil,                                   │
            │   power: nil,                                    │
            │   pp: 30,                                        │
            │   accuracy: nil,                                 │
            │   priority: nil,                                 │
            │   targetId: nil,                                 │
            │   effectId: nil,                                 │
            │   effectChance: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIMoveChangelog(                            │
            │   moveId: Tagged(rawValue: 16),                  │
            │   changedInVersionGroupId: Tagged(rawValue: 3),  │
            │   typeId: Tagged(rawValue: 1),                   │
            │   power: nil,                                    │
            │   pp: nil,                                       │
            │   accuracy: nil,                                 │
            │   priority: nil,                                 │
            │   targetId: nil,                                 │
            │   effectId: Tagged(rawValue: 1),                 │
            │   effectChance: nil                              │
            │ )                                                │
            ├──────────────────────────────────────────────────┤
            │ PokeAPIMoveChangelog(                            │
            │   moveId: Tagged(rawValue: 17),                  │
            │   changedInVersionGroupId: Tagged(rawValue: 3),  │
            │   typeId: nil,                                   │
            │   power: 35,                                     │
            │   pp: nil,                                       │
            │   accuracy: nil,                                 │
            │   priority: nil,                                 │
            │   targetId: nil,                                 │
            │   effectId: nil,                                 │
            │   effectChance: nil                              │
            │ )                                                │
            └──────────────────────────────────────────────────┘
            """
        }
    }
}
