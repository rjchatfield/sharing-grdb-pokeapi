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
struct PokeAPIPokemonEvolutionTests {
    @Test
        func testPokemonEvolutionBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonEvolution.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_evolution"
                """
            } results: {
                """
                ┌─────┐
                │ 507 │
                └─────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonEvolution.limit(5)
            ) {
                """
                SELECT "pokemon_evolution"."id", "pokemon_evolution"."evolved_species_id", "pokemon_evolution"."evolution_trigger_id", "pokemon_evolution"."trigger_item_id", "pokemon_evolution"."minimum_level", "pokemon_evolution"."gender_id", "pokemon_evolution"."location_id", "pokemon_evolution"."held_item_id", "pokemon_evolution"."time_of_day", "pokemon_evolution"."known_move_id", "pokemon_evolution"."known_move_type_id", "pokemon_evolution"."minimum_happiness", "pokemon_evolution"."minimum_beauty", "pokemon_evolution"."minimum_affection", "pokemon_evolution"."relative_physical_stats", "pokemon_evolution"."party_species_id", "pokemon_evolution"."party_type_id", "pokemon_evolution"."trade_species_id", "pokemon_evolution"."needs_overworld_rain", "pokemon_evolution"."turn_upside_down"
                FROM "pokemon_evolution"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────────────────────┐
                │ PokeAPIPokemonEvolution(                   │
                │   id: Tagged(rawValue: 1),                 │
                │   evolvedSpeciesId: Tagged(rawValue: 2),   │
                │   evolutionTriggerId: Tagged(rawValue: 1), │
                │   triggerItemId: nil,                      │
                │   minimumLevel: "16",                      │
                │   genderId: nil,                           │
                │   locationId: nil,                         │
                │   heldItemId: nil,                         │
                │   timeOfDay: nil,                          │
                │   knownMoveId: nil,                        │
                │   knownMoveTypeId: nil,                    │
                │   minimumHappiness: nil,                   │
                │   minimumBeauty: nil,                      │
                │   minimumAffection: nil,                   │
                │   relativePhysicalStats: nil,              │
                │   partySpeciesId: nil,                     │
                │   partyTypeId: nil,                        │
                │   tradeSpeciesId: nil,                     │
                │   needsOverworldRain: false,               │
                │   turnUpsideDown: false                    │
                │ )                                          │
                ├────────────────────────────────────────────┤
                │ PokeAPIPokemonEvolution(                   │
                │   id: Tagged(rawValue: 2),                 │
                │   evolvedSpeciesId: Tagged(rawValue: 3),   │
                │   evolutionTriggerId: Tagged(rawValue: 1), │
                │   triggerItemId: nil,                      │
                │   minimumLevel: "32",                      │
                │   genderId: nil,                           │
                │   locationId: nil,                         │
                │   heldItemId: nil,                         │
                │   timeOfDay: nil,                          │
                │   knownMoveId: nil,                        │
                │   knownMoveTypeId: nil,                    │
                │   minimumHappiness: nil,                   │
                │   minimumBeauty: nil,                      │
                │   minimumAffection: nil,                   │
                │   relativePhysicalStats: nil,              │
                │   partySpeciesId: nil,                     │
                │   partyTypeId: nil,                        │
                │   tradeSpeciesId: nil,                     │
                │   needsOverworldRain: false,               │
                │   turnUpsideDown: false                    │
                │ )                                          │
                ├────────────────────────────────────────────┤
                │ PokeAPIPokemonEvolution(                   │
                │   id: Tagged(rawValue: 3),                 │
                │   evolvedSpeciesId: Tagged(rawValue: 5),   │
                │   evolutionTriggerId: Tagged(rawValue: 1), │
                │   triggerItemId: nil,                      │
                │   minimumLevel: "16",                      │
                │   genderId: nil,                           │
                │   locationId: nil,                         │
                │   heldItemId: nil,                         │
                │   timeOfDay: nil,                          │
                │   knownMoveId: nil,                        │
                │   knownMoveTypeId: nil,                    │
                │   minimumHappiness: nil,                   │
                │   minimumBeauty: nil,                      │
                │   minimumAffection: nil,                   │
                │   relativePhysicalStats: nil,              │
                │   partySpeciesId: nil,                     │
                │   partyTypeId: nil,                        │
                │   tradeSpeciesId: nil,                     │
                │   needsOverworldRain: false,               │
                │   turnUpsideDown: false                    │
                │ )                                          │
                ├────────────────────────────────────────────┤
                │ PokeAPIPokemonEvolution(                   │
                │   id: Tagged(rawValue: 4),                 │
                │   evolvedSpeciesId: Tagged(rawValue: 6),   │
                │   evolutionTriggerId: Tagged(rawValue: 1), │
                │   triggerItemId: nil,                      │
                │   minimumLevel: "36",                      │
                │   genderId: nil,                           │
                │   locationId: nil,                         │
                │   heldItemId: nil,                         │
                │   timeOfDay: nil,                          │
                │   knownMoveId: nil,                        │
                │   knownMoveTypeId: nil,                    │
                │   minimumHappiness: nil,                   │
                │   minimumBeauty: nil,                      │
                │   minimumAffection: nil,                   │
                │   relativePhysicalStats: nil,              │
                │   partySpeciesId: nil,                     │
                │   partyTypeId: nil,                        │
                │   tradeSpeciesId: nil,                     │
                │   needsOverworldRain: false,               │
                │   turnUpsideDown: false                    │
                │ )                                          │
                ├────────────────────────────────────────────┤
                │ PokeAPIPokemonEvolution(                   │
                │   id: Tagged(rawValue: 5),                 │
                │   evolvedSpeciesId: Tagged(rawValue: 8),   │
                │   evolutionTriggerId: Tagged(rawValue: 1), │
                │   triggerItemId: nil,                      │
                │   minimumLevel: "16",                      │
                │   genderId: nil,                           │
                │   locationId: nil,                         │
                │   heldItemId: nil,                         │
                │   timeOfDay: nil,                          │
                │   knownMoveId: nil,                        │
                │   knownMoveTypeId: nil,                    │
                │   minimumHappiness: nil,                   │
                │   minimumBeauty: nil,                      │
                │   minimumAffection: nil,                   │
                │   relativePhysicalStats: nil,              │
                │   partySpeciesId: nil,                     │
                │   partyTypeId: nil,                        │
                │   tradeSpeciesId: nil,                     │
                │   needsOverworldRain: false,               │
                │   turnUpsideDown: false                    │
                │ )                                          │
                └────────────────────────────────────────────┘
                """
            }
        }
}
