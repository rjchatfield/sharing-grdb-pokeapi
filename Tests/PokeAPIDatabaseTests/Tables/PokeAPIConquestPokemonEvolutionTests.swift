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
struct PokeAPIConquestPokemonEvolutionTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestPokemonEvolution.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_pokemon_evolution"
            """
        } results: {
            """
            ┌─────┐
            │ 113 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestPokemonEvolution.limit(5)
        ) {
            """
            SELECT "conquest_pokemon_evolution"."evolved_species_id", "conquest_pokemon_evolution"."required_stat_id", "conquest_pokemon_evolution"."minimum_stat", "conquest_pokemon_evolution"."minimum_link", "conquest_pokemon_evolution"."kingdom_id", "conquest_pokemon_evolution"."warrior_gender_id", "conquest_pokemon_evolution"."item_id", "conquest_pokemon_evolution"."recruiting_ko_required"
            FROM "conquest_pokemon_evolution"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIConquestPokemonEvolution(          │
            │   evolvedSpeciesId: Tagged(rawValue: 5),  │
            │   requiredStatId: Tagged(rawValue: 2),    │
            │   minimumStat: 50,                        │
            │   minimumLink: nil,                       │
            │   kingdomId: nil,                         │
            │   warriorGenderId: nil,                   │
            │   itemId: nil,                            │
            │   recruitingKoRequired: 0                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonEvolution(          │
            │   evolvedSpeciesId: Tagged(rawValue: 6),  │
            │   requiredStatId: Tagged(rawValue: 2),    │
            │   minimumStat: 83,                        │
            │   minimumLink: nil,                       │
            │   kingdomId: nil,                         │
            │   warriorGenderId: nil,                   │
            │   itemId: nil,                            │
            │   recruitingKoRequired: 0                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonEvolution(          │
            │   evolvedSpeciesId: Tagged(rawValue: 24), │
            │   requiredStatId: Tagged(rawValue: 2),    │
            │   minimumStat: 59,                        │
            │   minimumLink: nil,                       │
            │   kingdomId: nil,                         │
            │   warriorGenderId: nil,                   │
            │   itemId: nil,                            │
            │   recruitingKoRequired: 0                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonEvolution(          │
            │   evolvedSpeciesId: Tagged(rawValue: 25), │
            │   requiredStatId: nil,                    │
            │   minimumStat: nil,                       │
            │   minimumLink: 50,                        │
            │   kingdomId: nil,                         │
            │   warriorGenderId: nil,                   │
            │   itemId: nil,                            │
            │   recruitingKoRequired: 0                 │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestPokemonEvolution(          │
            │   evolvedSpeciesId: Tagged(rawValue: 26), │
            │   requiredStatId: nil,                    │
            │   minimumStat: nil,                       │
            │   minimumLink: nil,                       │
            │   kingdomId: nil,                         │
            │   warriorGenderId: nil,                   │
            │   itemId: Tagged(rawValue: 83),           │
            │   recruitingKoRequired: 0                 │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}
