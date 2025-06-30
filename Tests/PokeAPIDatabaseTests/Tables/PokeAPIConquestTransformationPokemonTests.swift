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
struct PokeAPIConquestTransformationPokemonTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestTransformationPokemon.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_transformation_pokemon"
            """
        } results: {
            """
            ┌────┐
            │ 89 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestTransformationPokemon.limit(5)
        ) {
            """
            SELECT "conquest_transformation_pokemon"."transformation_id", "conquest_transformation_pokemon"."pokemon_species_id"
            FROM "conquest_transformation_pokemon"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIConquestTransformationPokemon(     │
            │   transformationId: 3,                    │
            │   pokemonSpeciesId: Tagged(rawValue: 133) │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestTransformationPokemon(     │
            │   transformationId: 3,                    │
            │   pokemonSpeciesId: Tagged(rawValue: 134) │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestTransformationPokemon(     │
            │   transformationId: 3,                    │
            │   pokemonSpeciesId: Tagged(rawValue: 135) │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestTransformationPokemon(     │
            │   transformationId: 3,                    │
            │   pokemonSpeciesId: Tagged(rawValue: 136) │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestTransformationPokemon(     │
            │   transformationId: 3,                    │
            │   pokemonSpeciesId: Tagged(rawValue: 196) │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}