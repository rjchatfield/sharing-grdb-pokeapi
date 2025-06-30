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
struct PokeAPIMoveBattleStyleTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveBattleStyle.count()
        ) {
            """
            SELECT count(*)
            FROM "move_battle_styles"
            """
        } results: {
            """
            ┌───┐
            │ 3 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveBattleStyle.limit(5)
        ) {
            """
            SELECT "move_battle_styles"."id", "move_battle_styles"."identifier"
            FROM "move_battle_styles"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIMoveBattleStyle(    │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "attack"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveBattleStyle(    │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "defense"    │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveBattleStyle(    │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "support"    │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}