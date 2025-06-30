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
struct PokeAPIContestComboTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIContestCombo.count()
        ) {
            """
            SELECT count(*)
            FROM "contest_combos"
            """
        } results: {
            """
            ┌─────┐
            │ 235 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIContestCombo.limit(5)
        ) {
            """
            SELECT "contest_combos"."first_move_id", "contest_combos"."second_move_id"
            FROM "contest_combos"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIContestCombo(                  │
            │   firstMoveId: Tagged(rawValue: 1),   │
            │   secondMoveId: Tagged(rawValue: 3)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIContestCombo(                  │
            │   firstMoveId: Tagged(rawValue: 1),   │
            │   secondMoveId: Tagged(rawValue: 21)  │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIContestCombo(                  │
            │   firstMoveId: Tagged(rawValue: 1),   │
            │   secondMoveId: Tagged(rawValue: 185) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIContestCombo(                  │
            │   firstMoveId: Tagged(rawValue: 7),   │
            │   secondMoveId: Tagged(rawValue: 8)   │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIContestCombo(                  │
            │   firstMoveId: Tagged(rawValue: 7),   │
            │   secondMoveId: Tagged(rawValue: 9)   │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}