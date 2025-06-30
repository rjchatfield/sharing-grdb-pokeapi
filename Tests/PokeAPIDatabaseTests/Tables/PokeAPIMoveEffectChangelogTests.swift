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
struct PokeAPIMoveEffectChangelogTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveEffectChangelog.count()
        ) {
            """
            SELECT count(*)
            FROM "move_effect_changelog"
            """
        } results: {
            """
            ┌────┐
            │ 28 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveEffectChangelog.limit(5)
        ) {
            """
            SELECT "move_effect_changelog"."id", "move_effect_changelog"."effect_id", "move_effect_changelog"."changed_in_version_group_id"
            FROM "move_effect_changelog"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────────────────┐
            │ PokeAPIMoveEffectChangelog(                     │
            │   id: Tagged(rawValue: 1),                      │
            │   effectId: Tagged(rawValue: 8),                │
            │   changedInVersionGroupId: Tagged(rawValue: 11) │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIMoveEffectChangelog(                     │
            │   id: Tagged(rawValue: 2),                      │
            │   effectId: Tagged(rawValue: 18),               │
            │   changedInVersionGroupId: Tagged(rawValue: 3)  │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIMoveEffectChangelog(                     │
            │   id: Tagged(rawValue: 3),                      │
            │   effectId: Tagged(rawValue: 29),               │
            │   changedInVersionGroupId: Tagged(rawValue: 3)  │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIMoveEffectChangelog(                     │
            │   id: Tagged(rawValue: 4),                      │
            │   effectId: Tagged(rawValue: 38),               │
            │   changedInVersionGroupId: Tagged(rawValue: 8)  │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIMoveEffectChangelog(                     │
            │   id: Tagged(rawValue: 5),                      │
            │   effectId: Tagged(rawValue: 46),               │
            │   changedInVersionGroupId: Tagged(rawValue: 3)  │
            │ )                                               │
            └─────────────────────────────────────────────────┘
            """
        }
    }
}