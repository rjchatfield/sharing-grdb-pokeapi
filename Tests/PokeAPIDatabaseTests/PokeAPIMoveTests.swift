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
struct PokeAPIMoveTests {
    @Test
        func testMoveBasicQuery() {
            Helper.assertQuery(
                PokeAPIMove.count()
            ) {
                """
                SELECT count(*)
                FROM "moves"
                """
            } results: {
                """
                ┌─────┐
                │ 937 │
                └─────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIMove.limit(5)
            ) {
                """
                SELECT "moves"."id", "moves"."identifier", "moves"."generation_id", "moves"."type_id", "moves"."power", "moves"."pp", "moves"."accuracy", "moves"."priority", "moves"."target_id", "moves"."damage_class_id", "moves"."effect_id", "moves"."effect_chance", "moves"."contest_type_id", "moves"."contest_effect_id", "moves"."super_contest_effect_id"
                FROM "moves"
                LIMIT 5
                """
            } results: {
                """
                ┌───────────────────────────────────────┐
                │ PokeAPIMove(                          │
                │   id: Tagged(rawValue: 1),            │
                │   identifier: "pound",                │
                │   generationId: Tagged(rawValue: 1),  │
                │   typeId: Tagged(rawValue: 1),        │
                │   power: 40,                          │
                │   pp: 35,                             │
                │   accuracy: 100,                      │
                │   priority: 0,                        │
                │   targetId: 10,                       │
                │   damageClassId: Tagged(rawValue: 2), │
                │   effectId: 1,                        │
                │   effectChance: nil,                  │
                │   contestTypeId: 5,                   │
                │   contestEffectId: 1,                 │
                │   superContestEffectId: 5             │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIMove(                          │
                │   id: Tagged(rawValue: 2),            │
                │   identifier: "karate-chop",          │
                │   generationId: Tagged(rawValue: 1),  │
                │   typeId: Tagged(rawValue: 2),        │
                │   power: 50,                          │
                │   pp: 25,                             │
                │   accuracy: 100,                      │
                │   priority: 0,                        │
                │   targetId: 10,                       │
                │   damageClassId: Tagged(rawValue: 2), │
                │   effectId: 44,                       │
                │   effectChance: nil,                  │
                │   contestTypeId: 5,                   │
                │   contestEffectId: 2,                 │
                │   superContestEffectId: 5             │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIMove(                          │
                │   id: Tagged(rawValue: 3),            │
                │   identifier: "double-slap",          │
                │   generationId: Tagged(rawValue: 1),  │
                │   typeId: Tagged(rawValue: 1),        │
                │   power: 15,                          │
                │   pp: 10,                             │
                │   accuracy: 85,                       │
                │   priority: 0,                        │
                │   targetId: 10,                       │
                │   damageClassId: Tagged(rawValue: 2), │
                │   effectId: 30,                       │
                │   effectChance: nil,                  │
                │   contestTypeId: 5,                   │
                │   contestEffectId: 10,                │
                │   superContestEffectId: 7             │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIMove(                          │
                │   id: Tagged(rawValue: 4),            │
                │   identifier: "comet-punch",          │
                │   generationId: Tagged(rawValue: 1),  │
                │   typeId: Tagged(rawValue: 1),        │
                │   power: 18,                          │
                │   pp: 15,                             │
                │   accuracy: 85,                       │
                │   priority: 0,                        │
                │   targetId: 10,                       │
                │   damageClassId: Tagged(rawValue: 2), │
                │   effectId: 30,                       │
                │   effectChance: nil,                  │
                │   contestTypeId: 5,                   │
                │   contestEffectId: 12,                │
                │   superContestEffectId: 7             │
                │ )                                     │
                ├───────────────────────────────────────┤
                │ PokeAPIMove(                          │
                │   id: Tagged(rawValue: 5),            │
                │   identifier: "mega-punch",           │
                │   generationId: Tagged(rawValue: 1),  │
                │   typeId: Tagged(rawValue: 1),        │
                │   power: 80,                          │
                │   pp: 20,                             │
                │   accuracy: 85,                       │
                │   priority: 0,                        │
                │   targetId: 10,                       │
                │   damageClassId: Tagged(rawValue: 2), │
                │   effectId: 1,                        │
                │   effectChance: nil,                  │
                │   contestTypeId: 5,                   │
                │   contestEffectId: 1,                 │
                │   superContestEffectId: 18            │
                │ )                                     │
                └───────────────────────────────────────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIMove
                    .where { $0.effectChance != nil }
                    .count()
            ) {
                """
                SELECT count(*)
                FROM "moves"
                WHERE ("moves"."effect_chance" IS NOT NULL)
                """
            } results: {
                """
                ┌─────┐
                │ 218 │
                └─────┘
                """
            }
        }
}
