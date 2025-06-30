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
struct PokeAPIConquestMoveDataTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestMoveData.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_move_data"
            """
        } results: {
            """
            ┌─────┐
            │ 123 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestMoveData.limit(5)
        ) {
            """
            SELECT "conquest_move_data"."move_id", "conquest_move_data"."power", "conquest_move_data"."accuracy", "conquest_move_data"."effect_chance", "conquest_move_data"."effect_id", "conquest_move_data"."range_id", "conquest_move_data"."displacement_id"
            FROM "conquest_move_data"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestMoveData(          │
            │   moveId: Tagged(rawValue: 1),    │
            │   power: 26,                      │
            │   accuracy: 100,                  │
            │   effectChance: nil,              │
            │   effectId: Tagged(rawValue: 60), │
            │   rangeId: Tagged(rawValue: 2),   │
            │   displacementId: nil             │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveData(          │
            │   moveId: Tagged(rawValue: 2),    │
            │   power: 31,                      │
            │   accuracy: 100,                  │
            │   effectChance: nil,              │
            │   effectId: Tagged(rawValue: 9),  │
            │   rangeId: Tagged(rawValue: 2),   │
            │   displacementId: nil             │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveData(          │
            │   moveId: Tagged(rawValue: 3),    │
            │   power: 10,                      │
            │   accuracy: 90,                   │
            │   effectChance: nil,              │
            │   effectId: Tagged(rawValue: 14), │
            │   rangeId: Tagged(rawValue: 2),   │
            │   displacementId: nil             │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveData(          │
            │   moveId: Tagged(rawValue: 17),   │
            │   power: 31,                      │
            │   accuracy: 100,                  │
            │   effectChance: nil,              │
            │   effectId: Tagged(rawValue: 60), │
            │   rangeId: Tagged(rawValue: 2),   │
            │   displacementId: nil             │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestMoveData(          │
            │   moveId: Tagged(rawValue: 22),   │
            │   power: 24,                      │
            │   accuracy: 100,                  │
            │   effectChance: nil,              │
            │   effectId: Tagged(rawValue: 60), │
            │   rangeId: Tagged(rawValue: 7),   │
            │   displacementId: nil             │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}
