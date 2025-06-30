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
struct PokeAPIConquestPokemonMoveTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestPokemonMove.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_pokemon_moves"
            """
        } results: {
            """
            ┌─────┐
            │ 200 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestPokemonMove.limit(5)
        ) {
            """
            SELECT "conquest_pokemon_moves"."pokemon_species_id", "conquest_pokemon_moves"."move_id"
            FROM "conquest_pokemon_moves"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIConquestPokemonMove(               │
            │   pokemonSpeciesId: Tagged(rawValue: 4),  │
            │   moveId: Tagged(rawValue: 52)            │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonMove(               │
            │   pokemonSpeciesId: Tagged(rawValue: 5),  │
            │   moveId: Tagged(rawValue: 424)           │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonMove(               │
            │   pokemonSpeciesId: Tagged(rawValue: 6),  │
            │   moveId: Tagged(rawValue: 53)            │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonMove(               │
            │   pokemonSpeciesId: Tagged(rawValue: 15), │
            │   moveId: Tagged(rawValue: 41)            │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonMove(               │
            │   pokemonSpeciesId: Tagged(rawValue: 23), │
            │   moveId: Tagged(rawValue: 40)            │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}