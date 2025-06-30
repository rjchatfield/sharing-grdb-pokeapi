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
struct PokeAPIConquestMoveEffectTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestMoveEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_move_effects"
            """
        } results: {
            """
            ┌────┐
            │ 51 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestMoveEffect.limit(5)
        ) {
            """
            SELECT "conquest_move_effects"."id"
            FROM "conquest_move_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIConquestMoveEffect( │
            │   id: Tagged(rawValue: 1)  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestMoveEffect( │
            │   id: Tagged(rawValue: 2)  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestMoveEffect( │
            │   id: Tagged(rawValue: 3)  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestMoveEffect( │
            │   id: Tagged(rawValue: 4)  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIConquestMoveEffect( │
            │   id: Tagged(rawValue: 5)  │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}