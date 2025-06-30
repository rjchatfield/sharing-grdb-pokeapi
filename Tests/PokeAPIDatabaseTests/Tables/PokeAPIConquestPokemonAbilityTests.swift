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
struct PokeAPIConquestPokemonAbilityTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestPokemonAbility.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_pokemon_abilities"
            """
        } results: {
            """
            ┌─────┐
            │ 560 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestPokemonAbility.limit(5)
        ) {
            """
            SELECT "conquest_pokemon_abilities"."pokemon_species_id", "conquest_pokemon_abilities"."slot", "conquest_pokemon_abilities"."ability_id"
            FROM "conquest_pokemon_abilities"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIConquestPokemonAbility(           │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   slot: 1,                               │
            │   abilityId: Tagged(rawValue: 66)        │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonAbility(           │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   slot: 2,                               │
            │   abilityId: Tagged(rawValue: 10016)     │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonAbility(           │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   slot: 3,                               │
            │   abilityId: Tagged(rawValue: 10028)     │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonAbility(           │
            │   pokemonSpeciesId: Tagged(rawValue: 5), │
            │   slot: 1,                               │
            │   abilityId: Tagged(rawValue: 66)        │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonAbility(           │
            │   pokemonSpeciesId: Tagged(rawValue: 5), │
            │   slot: 2,                               │
            │   abilityId: Tagged(rawValue: 10016)     │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}