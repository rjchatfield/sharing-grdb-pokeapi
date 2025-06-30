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
struct PokeAPIStatTests {
    @Test
        func testStatBasicQuery() {
            Helper.assertQuery(
                PokeAPIStat.count()
            ) {
                """
                SELECT count(*)
                FROM "stats"
                """
            } results: {
                """
                ┌───┐
                │ 8 │
                └───┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIStat.limit(5)
            ) {
                """
                SELECT "stats"."id", "stats"."identifier", "stats"."damage_class_id", "stats"."is_battle_only", "stats"."game_index"
                FROM "stats"
                LIMIT 5
                """
            } results: {
                """
                ┌───────────────────────────────────────┐
                │ PokeAPIStat(                          │
                │   id: .hp,                            │
                │   identifier: .hp,                    │
                │   damageClassId: nil,                 │
                │   isBattleOnly: false,                │
                │   gameIndex: 1                        │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIStat(                          │
                │   id: .attack,                        │
                │   identifier: .attack,                │
                │   damageClassId: Tagged(rawValue: 2), │
                │   isBattleOnly: false,                │
                │   gameIndex: 2                        │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIStat(                          │
                │   id: .defense,                       │
                │   identifier: .defense,               │
                │   damageClassId: Tagged(rawValue: 2), │
                │   isBattleOnly: false,                │
                │   gameIndex: 3                        │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIStat(                          │
                │   id: .specialAttack,                 │
                │   identifier: .specialAttack,         │
                │   damageClassId: Tagged(rawValue: 3), │
                │   isBattleOnly: false,                │
                │   gameIndex: 5                        │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIStat(                          │
                │   id: .specialDefense,                │
                │   identifier: .specialDefense,        │
                │   damageClassId: Tagged(rawValue: 3), │
                │   isBattleOnly: false,                │
                │   gameIndex: 6                        │
                │ )                                     │
                └───────────────────────────────────────┘
                """
            }
        }
}
