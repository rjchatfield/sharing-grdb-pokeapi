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
struct PokeAPIConquestMoveDisplacementTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestMoveDisplacement.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_move_displacements"
            """
        } results: {
            """
            ┌───┐
            │ 5 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestMoveDisplacement.limit(5)
        ) {
            """
            SELECT "conquest_move_displacements"."id", "conquest_move_displacements"."identifier", "conquest_move_displacements"."affects_target"
            FROM "conquest_move_displacements"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestMoveDisplacement(  │
            │   id: Tagged(rawValue: 1),        │
            │   identifier: "advance-1",        │
            │   affectsTarget: 0                │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveDisplacement(  │
            │   id: Tagged(rawValue: 2),        │
            │   identifier: "advance-2",        │
            │   affectsTarget: 0                │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveDisplacement(  │
            │   id: Tagged(rawValue: 3),        │
            │   identifier: "switch-back",      │
            │   affectsTarget: 0                │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveDisplacement(  │
            │   id: Tagged(rawValue: 4),        │
            │   identifier: "knockback",        │
            │   affectsTarget: 1                │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveDisplacement(  │
            │   id: Tagged(rawValue: 5),        │
            │   identifier: "knockback-switch", │
            │   affectsTarget: 1                │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}