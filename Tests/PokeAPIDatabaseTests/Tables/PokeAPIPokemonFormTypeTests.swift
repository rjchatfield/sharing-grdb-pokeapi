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
struct PokeAPIPokemonFormTypeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonFormType.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_form_types"
            """
        } results: {
            """
            ┌────┐
            │ 35 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonFormType.limit(5)
        ) {
            """
            SELECT "pokemon_form_types"."pokemon_form_id", "pokemon_form_types"."type_id", "pokemon_form_types"."slot"
            FROM "pokemon_form_types"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIPokemonFormType(                   │
            │   pokemonFormId: Tagged(rawValue: 10041), │
            │   typeId: Tagged(rawValue: 7),            │
            │   slot: 1                                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIPokemonFormType(                   │
            │   pokemonFormId: Tagged(rawValue: 10042), │
            │   typeId: Tagged(rawValue: 17),           │
            │   slot: 1                                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIPokemonFormType(                   │
            │   pokemonFormId: Tagged(rawValue: 10043), │
            │   typeId: Tagged(rawValue: 16),           │
            │   slot: 1                                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIPokemonFormType(                   │
            │   pokemonFormId: Tagged(rawValue: 10044), │
            │   typeId: Tagged(rawValue: 13),           │
            │   slot: 1                                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIPokemonFormType(                   │
            │   pokemonFormId: Tagged(rawValue: 10045), │
            │   typeId: Tagged(rawValue: 2),            │
            │   slot: 1                                 │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}