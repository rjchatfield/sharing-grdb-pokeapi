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
struct PokeAPIPokemonTypeTests {
    @Test
        func testPokemonTypeBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonType.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_types"
                """
            } results: {
                """
                ┌──────┐
                │ 2028 │
                └──────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonType.limit(5)
            ) {
                """
                SELECT "pokemon_types"."pokemon_id", "pokemon_types"."type_id", "pokemon_types"."slot"
                FROM "pokemon_types"
                LIMIT 5
                """
            } results: {
                """
                ┌───────────────────────────────────┐
                │ PokeAPIPokemonType(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   typeId: Tagged(rawValue: 12),   │
                │   slot: 1                         │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonType(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   typeId: Tagged(rawValue: 4),    │
                │   slot: 2                         │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonType(               │
                │   pokemonId: Tagged(rawValue: 2), │
                │   typeId: Tagged(rawValue: 12),   │
                │   slot: 1                         │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonType(               │
                │   pokemonId: Tagged(rawValue: 2), │
                │   typeId: Tagged(rawValue: 4),    │
                │   slot: 2                         │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonType(               │
                │   pokemonId: Tagged(rawValue: 3), │
                │   typeId: Tagged(rawValue: 12),   │
                │   slot: 1                         │
                │ )                                 │
                └───────────────────────────────────┘
                """
            }
        }
}
