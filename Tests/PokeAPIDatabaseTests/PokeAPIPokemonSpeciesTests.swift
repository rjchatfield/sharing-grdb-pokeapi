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
struct PokeAPIPokemonSpeciesTests {
    @Test
        func testPokemonSpeciesBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonSpecies.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_species"
                """
            } results: {
                """
                ┌──────┐
                │ 1025 │
                └──────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonSpecies.limit(5)
            ) {
                """
                SELECT "pokemon_species"."id", "pokemon_species"."identifier", "pokemon_species"."generation_id", "pokemon_species"."evolves_from_species_id", "pokemon_species"."evolution_chain_id", "pokemon_species"."color_id", "pokemon_species"."shape_id", "pokemon_species"."habitat_id", "pokemon_species"."gender_rate", "pokemon_species"."capture_rate", "pokemon_species"."base_happiness", "pokemon_species"."is_baby", "pokemon_species"."hatch_counter", "pokemon_species"."has_gender_differences", "pokemon_species"."growth_rate_id", "pokemon_species"."forms_switchable", "pokemon_species"."is_legendary", "pokemon_species"."is_mythical", "pokemon_species"."order", "pokemon_species"."conquest_order"
                FROM "pokemon_species"
                LIMIT 5
                """
            } results: {
                """
                ┌──────────────────────────────────────────────┐
                │ PokeAPIPokemonSpecies(                       │
                │   id: Tagged(rawValue: 1),                   │
                │   identifier: "bulbasaur",                   │
                │   generationId: Tagged(rawValue: 1),         │
                │   evolvesFromSpeciesId: nil,                 │
                │   evolutionChainId: Tagged(rawValue: 1),     │
                │   colorId: Tagged(rawValue: 5),              │
                │   shapeId: Tagged(rawValue: 8),              │
                │   habitatId: Tagged(rawValue: 3),            │
                │   genderRate: 1,                             │
                │   captureRate: 45,                           │
                │   baseHappiness: 70,                         │
                │   isBaby: false,                             │
                │   hatchCounter: 20,                          │
                │   hasGenderDifferences: false,               │
                │   growthRateId: Tagged(rawValue: 4),         │
                │   formsSwitchable: false,                    │
                │   isLegendary: false,                        │
                │   isMythical: false,                         │
                │   order: 1,                                  │
                │   conquestOrder: nil                         │
                │ )                                            │
                ├──────────────────────────────────────────────┤
                │ PokeAPIPokemonSpecies(                       │
                │   id: Tagged(rawValue: 2),                   │
                │   identifier: "ivysaur",                     │
                │   generationId: Tagged(rawValue: 1),         │
                │   evolvesFromSpeciesId: Tagged(rawValue: 1), │
                │   evolutionChainId: Tagged(rawValue: 1),     │
                │   colorId: Tagged(rawValue: 5),              │
                │   shapeId: Tagged(rawValue: 8),              │
                │   habitatId: Tagged(rawValue: 3),            │
                │   genderRate: 1,                             │
                │   captureRate: 45,                           │
                │   baseHappiness: 70,                         │
                │   isBaby: false,                             │
                │   hatchCounter: 20,                          │
                │   hasGenderDifferences: false,               │
                │   growthRateId: Tagged(rawValue: 4),         │
                │   formsSwitchable: false,                    │
                │   isLegendary: false,                        │
                │   isMythical: false,                         │
                │   order: 2,                                  │
                │   conquestOrder: nil                         │
                │ )                                            │
                ├──────────────────────────────────────────────┤
                │ PokeAPIPokemonSpecies(                       │
                │   id: Tagged(rawValue: 3),                   │
                │   identifier: "venusaur",                    │
                │   generationId: Tagged(rawValue: 1),         │
                │   evolvesFromSpeciesId: Tagged(rawValue: 2), │
                │   evolutionChainId: Tagged(rawValue: 1),     │
                │   colorId: Tagged(rawValue: 5),              │
                │   shapeId: Tagged(rawValue: 8),              │
                │   habitatId: Tagged(rawValue: 3),            │
                │   genderRate: 1,                             │
                │   captureRate: 45,                           │
                │   baseHappiness: 70,                         │
                │   isBaby: false,                             │
                │   hatchCounter: 20,                          │
                │   hasGenderDifferences: true,                │
                │   growthRateId: Tagged(rawValue: 4),         │
                │   formsSwitchable: true,                     │
                │   isLegendary: false,                        │
                │   isMythical: false,                         │
                │   order: 3,                                  │
                │   conquestOrder: nil                         │
                │ )                                            │
                ├──────────────────────────────────────────────┤
                │ PokeAPIPokemonSpecies(                       │
                │   id: Tagged(rawValue: 4),                   │
                │   identifier: "charmander",                  │
                │   generationId: Tagged(rawValue: 1),         │
                │   evolvesFromSpeciesId: nil,                 │
                │   evolutionChainId: Tagged(rawValue: 2),     │
                │   colorId: Tagged(rawValue: 8),              │
                │   shapeId: Tagged(rawValue: 6),              │
                │   habitatId: Tagged(rawValue: 4),            │
                │   genderRate: 1,                             │
                │   captureRate: 45,                           │
                │   baseHappiness: 70,                         │
                │   isBaby: false,                             │
                │   hatchCounter: 20,                          │
                │   hasGenderDifferences: false,               │
                │   growthRateId: Tagged(rawValue: 4),         │
                │   formsSwitchable: false,                    │
                │   isLegendary: false,                        │
                │   isMythical: false,                         │
                │   order: 4,                                  │
                │   conquestOrder: 109                         │
                │ )                                            │
                ├──────────────────────────────────────────────┤
                │ PokeAPIPokemonSpecies(                       │
                │   id: Tagged(rawValue: 5),                   │
                │   identifier: "charmeleon",                  │
                │   generationId: Tagged(rawValue: 1),         │
                │   evolvesFromSpeciesId: Tagged(rawValue: 4), │
                │   evolutionChainId: Tagged(rawValue: 2),     │
                │   colorId: Tagged(rawValue: 8),              │
                │   shapeId: Tagged(rawValue: 6),              │
                │   habitatId: Tagged(rawValue: 4),            │
                │   genderRate: 1,                             │
                │   captureRate: 45,                           │
                │   baseHappiness: 70,                         │
                │   isBaby: false,                             │
                │   hatchCounter: 20,                          │
                │   hasGenderDifferences: false,               │
                │   growthRateId: Tagged(rawValue: 4),         │
                │   formsSwitchable: false,                    │
                │   isLegendary: false,                        │
                │   isMythical: false,                         │
                │   order: 5,                                  │
                │   conquestOrder: 110                         │
                │ )                                            │
                └──────────────────────────────────────────────┘
                """
            }
        }
}
