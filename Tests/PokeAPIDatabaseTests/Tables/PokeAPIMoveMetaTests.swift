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
struct PokeAPIMoveMetaTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveMeta.count()
        ) {
            """
            SELECT count(*)
            FROM "move_meta"
            """
        } results: {
            """
            ┌─────┐
            │ 826 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveMeta.limit(5)
        ) {
            """
            SELECT "move_meta"."move_id", "move_meta"."meta_category_id", "move_meta"."meta_ailment_id", "move_meta"."min_hits", "move_meta"."max_hits", "move_meta"."min_turns", "move_meta"."max_turns", "move_meta"."drain", "move_meta"."healing", "move_meta"."crit_rate", "move_meta"."ailment_chance", "move_meta"."flinch_chance", "move_meta"."stat_chance"
            FROM "move_meta"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPIMoveMeta(                       │
            │   moveId: Tagged(rawValue: 1),         │
            │   metaCategoryId: Tagged(rawValue: 0), │
            │   metaAilmentId: Tagged(rawValue: 0),  │
            │   minHits: nil,                        │
            │   maxHits: nil,                        │
            │   minTurns: nil,                       │
            │   maxTurns: nil,                       │
            │   drain: 0,                            │
            │   healing: 0,                          │
            │   critRate: 0,                         │
            │   ailmentChance: 0,                    │
            │   flinchChance: 0,                     │
            │   statChance: 0                        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIMoveMeta(                       │
            │   moveId: Tagged(rawValue: 2),         │
            │   metaCategoryId: Tagged(rawValue: 0), │
            │   metaAilmentId: Tagged(rawValue: 0),  │
            │   minHits: nil,                        │
            │   maxHits: nil,                        │
            │   minTurns: nil,                       │
            │   maxTurns: nil,                       │
            │   drain: 0,                            │
            │   healing: 0,                          │
            │   critRate: 1,                         │
            │   ailmentChance: 0,                    │
            │   flinchChance: 0,                     │
            │   statChance: 0                        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIMoveMeta(                       │
            │   moveId: Tagged(rawValue: 3),         │
            │   metaCategoryId: Tagged(rawValue: 0), │
            │   metaAilmentId: Tagged(rawValue: 0),  │
            │   minHits: 2,                          │
            │   maxHits: 5,                          │
            │   minTurns: nil,                       │
            │   maxTurns: nil,                       │
            │   drain: 0,                            │
            │   healing: 0,                          │
            │   critRate: 0,                         │
            │   ailmentChance: 0,                    │
            │   flinchChance: 0,                     │
            │   statChance: 0                        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIMoveMeta(                       │
            │   moveId: Tagged(rawValue: 4),         │
            │   metaCategoryId: Tagged(rawValue: 0), │
            │   metaAilmentId: Tagged(rawValue: 0),  │
            │   minHits: 2,                          │
            │   maxHits: 5,                          │
            │   minTurns: nil,                       │
            │   maxTurns: nil,                       │
            │   drain: 0,                            │
            │   healing: 0,                          │
            │   critRate: 0,                         │
            │   ailmentChance: 0,                    │
            │   flinchChance: 0,                     │
            │   statChance: 0                        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIMoveMeta(                       │
            │   moveId: Tagged(rawValue: 5),         │
            │   metaCategoryId: Tagged(rawValue: 0), │
            │   metaAilmentId: Tagged(rawValue: 0),  │
            │   minHits: nil,                        │
            │   maxHits: nil,                        │
            │   minTurns: nil,                       │
            │   maxTurns: nil,                       │
            │   drain: 0,                            │
            │   healing: 0,                          │
            │   critRate: 0,                         │
            │   ailmentChance: 0,                    │
            │   flinchChance: 0,                     │
            │   statChance: 0                        │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
}
