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
struct PokeAPIContestEffectTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIContestEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "contest_effects"
            """
        } results: {
            """
            ┌────┐
            │ 33 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIContestEffect.limit(5)
        ) {
            """
            SELECT "contest_effects"."id", "contest_effects"."appeal", "contest_effects"."jam"
            FROM "contest_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIContestEffect(      │
            │   id: Tagged(rawValue: 1), │
            │   appeal: 4,               │
            │   jam: 0                   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestEffect(      │
            │   id: Tagged(rawValue: 2), │
            │   appeal: 3,               │
            │   jam: 0                   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestEffect(      │
            │   id: Tagged(rawValue: 3), │
            │   appeal: 6,               │
            │   jam: 0                   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestEffect(      │
            │   id: Tagged(rawValue: 4), │
            │   appeal: 1,               │
            │   jam: 4                   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestEffect(      │
            │   id: Tagged(rawValue: 5), │
            │   appeal: 1,               │
            │   jam: 3                   │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}