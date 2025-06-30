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
struct PokeAPIAbilityChangelogTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIAbilityChangelog.count()
        ) {
            """
            SELECT count(*)
            FROM "ability_changelog"
            """
        } results: {
            """
            ┌────┐
            │ 52 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIAbilityChangelog.limit(5)
        ) {
            """
            SELECT "ability_changelog"."id", "ability_changelog"."ability_id", "ability_changelog"."changed_in_version_group_id"
            FROM "ability_changelog"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────────────────┐
            │ PokeAPIAbilityChangelog(                        │
            │   id: Tagged(rawValue: 1),                      │
            │   abilityId: Tagged(rawValue: 1),               │
            │   changedInVersionGroupId: Tagged(rawValue: 11) │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIAbilityChangelog(                        │
            │   id: Tagged(rawValue: 2),                      │
            │   abilityId: Tagged(rawValue: 5),               │
            │   changedInVersionGroupId: Tagged(rawValue: 11) │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIAbilityChangelog(                        │
            │   id: Tagged(rawValue: 3),                      │
            │   abilityId: Tagged(rawValue: 9),               │
            │   changedInVersionGroupId: Tagged(rawValue: 6)  │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIAbilityChangelog(                        │
            │   id: Tagged(rawValue: 4),                      │
            │   abilityId: Tagged(rawValue: 10),              │
            │   changedInVersionGroupId: Tagged(rawValue: 8)  │
            │ )                                               │
            ├─────────────────────────────────────────────────┤
            │ PokeAPIAbilityChangelog(                        │
            │   id: Tagged(rawValue: 5),                      │
            │   abilityId: Tagged(rawValue: 16),              │
            │   changedInVersionGroupId: Tagged(rawValue: 11) │
            │ )                                               │
            └─────────────────────────────────────────────────┘
            """
        }
    }
}