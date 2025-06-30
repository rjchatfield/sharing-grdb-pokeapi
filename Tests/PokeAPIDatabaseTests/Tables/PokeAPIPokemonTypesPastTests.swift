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
struct PokeAPIPokemonTypesPastTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonTypesPast.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_types_past"
            """
        } results: {
            """
            ┌────┐
            │ 36 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonTypesPast.limit(5)
        ) {
            """
            SELECT "pokemon_types_past"."pokemon_id", "pokemon_types_past"."generation_id", "pokemon_types_past"."type_id", "pokemon_types_past"."slot"
            FROM "pokemon_types_past"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIPokemonTypesPast(             │
            │   pokemonId: Tagged(rawValue: 35),   │
            │   generationId: Tagged(rawValue: 5), │
            │   typeId: Tagged(rawValue: 1),       │
            │   slot: 1                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonTypesPast(             │
            │   pokemonId: Tagged(rawValue: 36),   │
            │   generationId: Tagged(rawValue: 5), │
            │   typeId: Tagged(rawValue: 1),       │
            │   slot: 1                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonTypesPast(             │
            │   pokemonId: Tagged(rawValue: 39),   │
            │   generationId: Tagged(rawValue: 5), │
            │   typeId: Tagged(rawValue: 1),       │
            │   slot: 1                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonTypesPast(             │
            │   pokemonId: Tagged(rawValue: 40),   │
            │   generationId: Tagged(rawValue: 5), │
            │   typeId: Tagged(rawValue: 1),       │
            │   slot: 1                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonTypesPast(             │
            │   pokemonId: Tagged(rawValue: 81),   │
            │   generationId: Tagged(rawValue: 1), │
            │   typeId: Tagged(rawValue: 13),      │
            │   slot: 1                            │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}