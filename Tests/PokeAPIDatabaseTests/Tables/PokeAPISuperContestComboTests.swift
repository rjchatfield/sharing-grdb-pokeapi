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
struct PokeAPISuperContestComboTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPISuperContestCombo.count()
        ) {
            """
            SELECT count(*)
            FROM "super_contest_combos"
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
            PokeAPISuperContestCombo.limit(5)
        ) {
            """
            SELECT "super_contest_combos"."first_move_id", "super_contest_combos"."second_move_id"
            FROM "super_contest_combos"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPISuperContestCombo(             │
            │   firstMoveId: Tagged(rawValue: 74),  │
            │   secondMoveId: Tagged(rawValue: 345) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPISuperContestCombo(             │
            │   firstMoveId: Tagged(rawValue: 96),  │
            │   secondMoveId: Tagged(rawValue: 136) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPISuperContestCombo(             │
            │   firstMoveId: Tagged(rawValue: 111), │
            │   secondMoveId: Tagged(rawValue: 205) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPISuperContestCombo(             │
            │   firstMoveId: Tagged(rawValue: 116), │
            │   secondMoveId: Tagged(rawValue: 400) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPISuperContestCombo(             │
            │   firstMoveId: Tagged(rawValue: 244), │
            │   secondMoveId: Tagged(rawValue: 56)  │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}