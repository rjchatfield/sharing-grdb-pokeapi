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
struct PokeAPIPokemonMoveTests {
    @Test
        func testPokemonMoveBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonMove.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_moves"
                """
            } results: {
                """
                ┌────────┐
                │ 609926 │
                └────────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonMove.limit(5)
            ) {
                """
                SELECT "pokemon_moves"."pokemon_id", "pokemon_moves"."version_group_id", "pokemon_moves"."move_id", "pokemon_moves"."pokemon_move_method_id", "pokemon_moves"."level", "pokemon_moves"."order", "pokemon_moves"."mastery"
                FROM "pokemon_moves"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────────────────┐
                │ PokeAPIPokemonMove(                    │
                │   pokemonId: Tagged(rawValue: 1),      │
                │   versionGroupId: Tagged(rawValue: 1), │
                │   moveId: Tagged(rawValue: 33),        │
                │   pokemonMoveMethodId: 1,              │
                │   level: 1,                            │
                │   order: 1,                            │
                │   mastery: nil                         │
                │ )                                      │
                ├────────────────────────────────────────┤
                │ PokeAPIPokemonMove(                    │
                │   pokemonId: Tagged(rawValue: 1),      │
                │   versionGroupId: Tagged(rawValue: 1), │
                │   moveId: Tagged(rawValue: 45),        │
                │   pokemonMoveMethodId: 1,              │
                │   level: 1,                            │
                │   order: 2,                            │
                │   mastery: nil                         │
                │ )                                      │
                ├────────────────────────────────────────┤
                │ PokeAPIPokemonMove(                    │
                │   pokemonId: Tagged(rawValue: 1),      │
                │   versionGroupId: Tagged(rawValue: 1), │
                │   moveId: Tagged(rawValue: 73),        │
                │   pokemonMoveMethodId: 1,              │
                │   level: 7,                            │
                │   order: nil,                          │
                │   mastery: nil                         │
                │ )                                      │
                ├────────────────────────────────────────┤
                │ PokeAPIPokemonMove(                    │
                │   pokemonId: Tagged(rawValue: 1),      │
                │   versionGroupId: Tagged(rawValue: 1), │
                │   moveId: Tagged(rawValue: 22),        │
                │   pokemonMoveMethodId: 1,              │
                │   level: 13,                           │
                │   order: nil,                          │
                │   mastery: nil                         │
                │ )                                      │
                ├────────────────────────────────────────┤
                │ PokeAPIPokemonMove(                    │
                │   pokemonId: Tagged(rawValue: 1),      │
                │   versionGroupId: Tagged(rawValue: 1), │
                │   moveId: Tagged(rawValue: 77),        │
                │   pokemonMoveMethodId: 1,              │
                │   level: 20,                           │
                │   order: nil,                          │
                │   mastery: nil                         │
                │ )                                      │
                └────────────────────────────────────────┘
                """
            }
        }
}
