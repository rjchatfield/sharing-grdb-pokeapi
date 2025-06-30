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
struct PokeAPIPokemonGameIndicesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonGameIndices.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_game_indices"
            """
        } results: {
            """
            ┌──────┐
            │ 8354 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonGameIndices.limit(5)
        ) {
            """
            SELECT "pokemon_game_indices"."pokemon_id", "pokemon_game_indices"."version_id", "pokemon_game_indices"."game_index"
            FROM "pokemon_game_indices"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPokemonGameIndices(        │
            │   pokemonId: Tagged(rawValue: 1), │
            │   versionId: Tagged(rawValue: 1), │
            │   gameIndex: 153                  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonGameIndices(        │
            │   pokemonId: Tagged(rawValue: 1), │
            │   versionId: Tagged(rawValue: 2), │
            │   gameIndex: 153                  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonGameIndices(        │
            │   pokemonId: Tagged(rawValue: 1), │
            │   versionId: Tagged(rawValue: 3), │
            │   gameIndex: 153                  │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonGameIndices(        │
            │   pokemonId: Tagged(rawValue: 1), │
            │   versionId: Tagged(rawValue: 4), │
            │   gameIndex: 1                    │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonGameIndices(        │
            │   pokemonId: Tagged(rawValue: 1), │
            │   versionId: Tagged(rawValue: 5), │
            │   gameIndex: 1                    │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}