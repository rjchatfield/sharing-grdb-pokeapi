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
struct PokeAPIPokemonAbilityTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonAbility.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_abilities"
            """
        } results: {
            """
            ┌──────┐
            │ 2917 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonAbility.limit(5)
        ) {
            """
            SELECT "pokemon_abilities"."pokemon_id", "pokemon_abilities"."ability_id", "pokemon_abilities"."is_hidden", "pokemon_abilities"."slot"
            FROM "pokemon_abilities"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIPokemonAbility(             │
            │   pokemonId: Tagged(rawValue: 1),  │
            │   abilityId: Tagged(rawValue: 65), │
            │   isHidden: false,                 │
            │   slot: 1                          │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonAbility(             │
            │   pokemonId: Tagged(rawValue: 1),  │
            │   abilityId: Tagged(rawValue: 34), │
            │   isHidden: true,                  │
            │   slot: 3                          │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonAbility(             │
            │   pokemonId: Tagged(rawValue: 2),  │
            │   abilityId: Tagged(rawValue: 65), │
            │   isHidden: false,                 │
            │   slot: 1                          │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonAbility(             │
            │   pokemonId: Tagged(rawValue: 2),  │
            │   abilityId: Tagged(rawValue: 34), │
            │   isHidden: true,                  │
            │   slot: 3                          │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonAbility(             │
            │   pokemonId: Tagged(rawValue: 3),  │
            │   abilityId: Tagged(rawValue: 65), │
            │   isHidden: false,                 │
            │   slot: 1                          │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
}
