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
struct PokeAPIPokemonAbilitiesPastTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonAbilitiesPast.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_abilities_past"
            """
        } results: {
            """
            ┌─────┐
            │ 569 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonAbilitiesPast.limit(5)
        ) {
            """
            SELECT "pokemon_abilities_past"."pokemon_id", "pokemon_abilities_past"."generation_id", "pokemon_abilities_past"."ability_id", "pokemon_abilities_past"."is_hidden", "pokemon_abilities_past"."slot"
            FROM "pokemon_abilities_past"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIPokemonAbilitiesPast(         │
            │   pokemonId: Tagged(rawValue: 1),    │
            │   generationId: Tagged(rawValue: 4), │
            │   abilityId: nil,                    │
            │   isHidden: 1,                       │
            │   slot: 3                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonAbilitiesPast(         │
            │   pokemonId: Tagged(rawValue: 2),    │
            │   generationId: Tagged(rawValue: 4), │
            │   abilityId: nil,                    │
            │   isHidden: 1,                       │
            │   slot: 3                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonAbilitiesPast(         │
            │   pokemonId: Tagged(rawValue: 3),    │
            │   generationId: Tagged(rawValue: 4), │
            │   abilityId: nil,                    │
            │   isHidden: 1,                       │
            │   slot: 3                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonAbilitiesPast(         │
            │   pokemonId: Tagged(rawValue: 4),    │
            │   generationId: Tagged(rawValue: 4), │
            │   abilityId: nil,                    │
            │   isHidden: 1,                       │
            │   slot: 3                            │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIPokemonAbilitiesPast(         │
            │   pokemonId: Tagged(rawValue: 5),    │
            │   generationId: Tagged(rawValue: 4), │
            │   abilityId: nil,                    │
            │   isHidden: 1,                       │
            │   slot: 3                            │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}
