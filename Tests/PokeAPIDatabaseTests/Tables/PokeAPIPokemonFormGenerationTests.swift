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
struct PokeAPIPokemonFormGenerationTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonFormGeneration.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_form_generations"
            """
        } results: {
            """
            ┌──────┐
            │ 4976 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonFormGeneration.limit(5)
        ) {
            """
            SELECT "pokemon_form_generations"."pokemon_form_id", "pokemon_form_generations"."generation_id", "pokemon_form_generations"."game_index"
            FROM "pokemon_form_generations"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIPokemonFormGeneration(         │
            │   pokemonFormId: Tagged(rawValue: 1), │
            │   generationId: Tagged(rawValue: 1),  │
            │   gameIndex: 0                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIPokemonFormGeneration(         │
            │   pokemonFormId: Tagged(rawValue: 1), │
            │   generationId: Tagged(rawValue: 2),  │
            │   gameIndex: 0                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIPokemonFormGeneration(         │
            │   pokemonFormId: Tagged(rawValue: 1), │
            │   generationId: Tagged(rawValue: 3),  │
            │   gameIndex: 0                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIPokemonFormGeneration(         │
            │   pokemonFormId: Tagged(rawValue: 1), │
            │   generationId: Tagged(rawValue: 4),  │
            │   gameIndex: 0                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIPokemonFormGeneration(         │
            │   pokemonFormId: Tagged(rawValue: 1), │
            │   generationId: Tagged(rawValue: 5),  │
            │   gameIndex: 0                        │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}