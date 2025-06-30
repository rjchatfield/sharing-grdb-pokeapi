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
struct PokeAPIPokemonDexNumberTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonDexNumber.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_dex_numbers"
            """
        } results: {
            """
            ┌──────┐
            │ 7412 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonDexNumber.limit(5)
        ) {
            """
            SELECT "pokemon_dex_numbers"."species_id", "pokemon_dex_numbers"."pokedex_id", "pokemon_dex_numbers"."pokedex_number"
            FROM "pokemon_dex_numbers"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 1),  │
            │   pokedexNumber: 1                 │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 2),  │
            │   pokedexNumber: 1                 │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 3),  │
            │   pokedexNumber: 226               │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 7),  │
            │   pokedexNumber: 231               │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 12), │
            │   pokedexNumber: 80                │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
}
