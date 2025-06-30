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
struct PokeAPIVersionGroupPokemonMoveMethodTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIVersionGroupPokemonMoveMethod.count()
        ) {
            """
            SELECT count(*)
            FROM "version_group_pokemon_move_methods"
            """
        } results: {
            """
            ┌────┐
            │ 99 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIVersionGroupPokemonMoveMethod.limit(5)
        ) {
            """
            SELECT "version_group_pokemon_move_methods"."version_group_id", "version_group_pokemon_move_methods"."pokemon_move_method_id"
            FROM "version_group_pokemon_move_methods"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────────┐
            │ PokeAPIVersionGroupPokemonMoveMethod(      │
            │   versionGroupId: Tagged(rawValue: 1),     │
            │   pokemonMoveMethodId: Tagged(rawValue: 1) │
            │ )                                          │
            ├────────────────────────────────────────────┤
            │ PokeAPIVersionGroupPokemonMoveMethod(      │
            │   versionGroupId: Tagged(rawValue: 1),     │
            │   pokemonMoveMethodId: Tagged(rawValue: 4) │
            │ )                                          │
            ├────────────────────────────────────────────┤
            │ PokeAPIVersionGroupPokemonMoveMethod(      │
            │   versionGroupId: Tagged(rawValue: 1),     │
            │   pokemonMoveMethodId: Tagged(rawValue: 5) │
            │ )                                          │
            ├────────────────────────────────────────────┤
            │ PokeAPIVersionGroupPokemonMoveMethod(      │
            │   versionGroupId: Tagged(rawValue: 2),     │
            │   pokemonMoveMethodId: Tagged(rawValue: 1) │
            │ )                                          │
            ├────────────────────────────────────────────┤
            │ PokeAPIVersionGroupPokemonMoveMethod(      │
            │   versionGroupId: Tagged(rawValue: 2),     │
            │   pokemonMoveMethodId: Tagged(rawValue: 4) │
            │ )                                          │
            └────────────────────────────────────────────┘
            """
        }
    }
}