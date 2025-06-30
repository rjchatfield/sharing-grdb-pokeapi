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
struct PokeAPISuperContestEffectTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPISuperContestEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "super_contest_effects"
            """
        } results: {
            """
            ┌────┐
            │ 22 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPISuperContestEffect.limit(5)
        ) {
            """
            SELECT "super_contest_effects"."id", "super_contest_effects"."appeal"
            FROM "super_contest_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPISuperContestEffect( │
            │   id: Tagged(rawValue: 1), │
            │   appeal: 2                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPISuperContestEffect( │
            │   id: Tagged(rawValue: 2), │
            │   appeal: 2                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPISuperContestEffect( │
            │   id: Tagged(rawValue: 4), │
            │   appeal: 2                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPISuperContestEffect( │
            │   id: Tagged(rawValue: 5), │
            │   appeal: 3                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPISuperContestEffect( │
            │   id: Tagged(rawValue: 6), │
            │   appeal: 1                │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}