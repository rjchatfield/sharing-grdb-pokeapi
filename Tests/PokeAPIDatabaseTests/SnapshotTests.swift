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
struct SnapshotTests {
    // MARK: - Basic query tests
    
    @Test
    func testAbilityBasicQuery() {
        Helper.assertQuery(
            PokeAPIAbility.limit(5)
        ) {
            """
            SELECT "abilities"."id", "abilities"."identifier", "abilities"."generation_id", "abilities"."is_main_series"
            FROM "abilities"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 1),           │
            │   identifier: "stench",              │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 2),           │
            │   identifier: "drizzle",             │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 3),           │
            │   identifier: "speed-boost",         │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 4),           │
            │   identifier: "battle-armor",        │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIAbility(                      │
            │   id: Tagged(rawValue: 5),           │
            │   identifier: "sturdy",              │
            │   generationId: Tagged(rawValue: 3), │
            │   isMainSeries: true                 │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testBerryBasicQuery() {
        Helper.assertQuery(
            PokeAPIBerry.limit(5)
        ) {
            """
            SELECT "berries"."id", "berries"."item_id", "berries"."firmness_id", "berries"."natural_gift_power", "berries"."natural_gift_type_id", "berries"."size", "berries"."max_harvest", "berries"."growth_time", "berries"."soil_dryness", "berries"."smoothness"
            FROM "berries"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 1),       │
            │   itemId: Tagged(rawValue: 126), │
            │   firmnessId: 2,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 10,         │
            │   size: 20,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 2),       │
            │   itemId: Tagged(rawValue: 127), │
            │   firmnessId: 5,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 11,         │
            │   size: 80,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 3),       │
            │   itemId: Tagged(rawValue: 128), │
            │   firmnessId: 1,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 13,         │
            │   size: 40,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 4),       │
            │   itemId: Tagged(rawValue: 129), │
            │   firmnessId: 3,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 12,         │
            │   size: 32,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIBerry(                    │
            │   id: Tagged(rawValue: 5),       │
            │   itemId: Tagged(rawValue: 130), │
            │   firmnessId: 5,                 │
            │   naturalGiftPower: 60,          │
            │   naturalGiftTypeId: 15,         │
            │   size: 50,                      │
            │   maxHarvest: 5,                 │
            │   growthTime: 3,                 │
            │   soilDryness: 15,               │
            │   smoothness: 25                 │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testEncounterBasicQuery() {
        Helper.assertQuery(
            PokeAPIEncounter.limit(5)
        ) {
            """
            SELECT "encounters"."id", "encounters"."version_id", "encounters"."location_area_id", "encounters"."encounter_slot_id", "encounters"."pokemon_id", "encounters"."min_level", "encounters"."max_level"
            FROM "encounters"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 1),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 28), │
            │   pokemonId: Tagged(rawValue: 72),       │
            │   minLevel: 20,                          │
            │   maxLevel: 30                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 2),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 29), │
            │   pokemonId: Tagged(rawValue: 278),      │
            │   minLevel: 20,                          │
            │   maxLevel: 30                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 3),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 30), │
            │   pokemonId: Tagged(rawValue: 73),       │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 4),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 31), │
            │   pokemonId: Tagged(rawValue: 279),      │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIEncounter(                        │
            │   id: Tagged(rawValue: 5),               │
            │   versionId: Tagged(rawValue: 12),       │
            │   locationAreaId: Tagged(rawValue: 1),   │
            │   encounterSlotId: Tagged(rawValue: 32), │
            │   pokemonId: Tagged(rawValue: 279),      │
            │   minLevel: 20,                          │
            │   maxLevel: 40                           │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testEncounterMethodBasicQuery() {
        Helper.assertQuery(
            PokeAPIEncounterMethod.limit(5)
        ) {
            """
            SELECT "encounter_methods"."id", "encounter_methods"."identifier", "encounter_methods"."order"
            FROM "encounter_methods"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "walk",      │
            │   order: 1                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "old-rod",   │
            │   order: 10                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "good-rod",  │
            │   order: 11                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "super-rod", │
            │   order: 12                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "surf",      │
            │   order: 14                │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testEncounterSlotBasicQuery() {
        Helper.assertQuery(
            PokeAPIEncounterSlot.limit(5)
        ) {
            """
            SELECT "encounter_slots"."id", "encounter_slots"."version_group_id", "encounter_slots"."encounter_method_id", "encounter_slots"."slot", "encounter_slots"."rarity"
            FROM "encounter_slots"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 1),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 1,                                │
            │   rarity: 20                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 2),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 2,                                │
            │   rarity: 20                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 3),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 3,                                │
            │   rarity: 10                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 4),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 4,                                │
            │   rarity: 10                              │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIEncounterSlot(                     │
            │   id: Tagged(rawValue: 5),                │
            │   versionGroupId: Tagged(rawValue: 8),    │
            │   encounterMethodId: Tagged(rawValue: 1), │
            │   slot: 5,                                │
            │   rarity: 10                              │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testEvolutionChainBasicQuery() {
        Helper.assertQuery(
            PokeAPIEvolutionChain.limit(5)
        ) {
            """
            SELECT "evolution_chains"."id", "evolution_chains"."baby_trigger_item_id"
            FROM "evolution_chains"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEvolutionChain(     │
            │   id: Tagged(rawValue: 1), │
            │   babyTriggerItemId: nil   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionChain(     │
            │   id: Tagged(rawValue: 2), │
            │   babyTriggerItemId: nil   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionChain(     │
            │   id: Tagged(rawValue: 3), │
            │   babyTriggerItemId: nil   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionChain(     │
            │   id: Tagged(rawValue: 4), │
            │   babyTriggerItemId: nil   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionChain(     │
            │   id: Tagged(rawValue: 5), │
            │   babyTriggerItemId: nil   │
            │ )                          │
            └────────────────────────────┘
            """
        }
        Helper.assertQuery(
            PokeAPIEvolutionChain
                .where({ $0.babyTriggerItemId != nil })
                .limit(2)
        ) {
            """
            SELECT "evolution_chains"."id", "evolution_chains"."baby_trigger_item_id"
            FROM "evolution_chains"
            WHERE ("evolution_chains"."baby_trigger_item_id" IS NOT NULL)
            LIMIT 2
            """
        } results: {
            """
            ┌────────────────────────────────────────────┐
            │ PokeAPIEvolutionChain(                     │
            │   id: Tagged(rawValue: 51),                │
            │   babyTriggerItemId: Tagged(rawValue: 296) │
            │ )                                          │
            ├────────────────────────────────────────────┤
            │ PokeAPIEvolutionChain(                     │
            │   id: Tagged(rawValue: 57),                │
            │   babyTriggerItemId: Tagged(rawValue: 291) │
            │ )                                          │
            └────────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testGenerationBasicQuery() {
        Helper.assertQuery(
            PokeAPIGeneration.limit(5)
        ) {
            """
            SELECT "generations"."id", "generations"."identifier", "generations"."main_region_id"
            FROM "generations"
            LIMIT 5
            """
        }results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPIGeneration(                  │
            │   id: Tagged(rawValue: 1),          │
            │   identifier: "generation-i",       │
            │   mainRegionId: Tagged(rawValue: 1) │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIGeneration(                  │
            │   id: Tagged(rawValue: 2),          │
            │   identifier: "generation-ii",      │
            │   mainRegionId: Tagged(rawValue: 2) │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIGeneration(                  │
            │   id: Tagged(rawValue: 3),          │
            │   identifier: "generation-iii",     │
            │   mainRegionId: Tagged(rawValue: 3) │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIGeneration(                  │
            │   id: Tagged(rawValue: 4),          │
            │   identifier: "generation-iv",      │
            │   mainRegionId: Tagged(rawValue: 4) │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIGeneration(                  │
            │   id: Tagged(rawValue: 5),          │
            │   identifier: "generation-v",       │
            │   mainRegionId: Tagged(rawValue: 5) │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testItemBasicQuery() {
        Helper.assertQuery(
            PokeAPIItem.limit(5)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 1),          │
            │   identifier: "master-ball",        │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 0,                          │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 2),          │
            │   identifier: "ultra-ball",         │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 800,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 3),          │
            │   identifier: "great-ball",         │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 600,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 4),          │
            │   identifier: "poke-ball",          │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 200,                        │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            ├─────────────────────────────────────┤
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 5),          │
            │   identifier: "safari-ball",        │
            │   categoryId: Tagged(rawValue: 34), │
            │   cost: 0,                          │
            │   flingPower: nil,                  │
            │   flingEffectId: nil                │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testItemCategoryBasicQuery() {
        Helper.assertQuery(
            PokeAPIItemCategory.limit(5)
        ) {
            """
            SELECT "item_categories"."id", "item_categories"."identifier", "item_categories"."pocket_id"
            FROM "item_categories"
            LIMIT 5
            """
        }results: {
            """
            ┌──────────────────────────────┐
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 1),   │
            │   identifier: "stat-boosts", │
            │   pocketId: 7                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 2),   │
            │   identifier: "effort-drop", │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 3),   │
            │   identifier: "medicine",    │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 4),   │
            │   identifier: "other",       │
            │   pocketId: 5                │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItemCategory(         │
            │   id: Tagged(rawValue: 5),   │
            │   identifier: "in-a-pinch",  │
            │   pocketId: 5                │
            │ )                            │
            └──────────────────────────────┘
            """
        }
    }
    
    @Test
    func testLocationBasicQuery() {
        Helper.assertQuery(
            PokeAPILocation.limit(5)
        ) {
            """
            SELECT "locations"."id", "locations"."identifier", "locations"."region_id"
            FROM "locations"
            LIMIT 5
            """
        }results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 1),             │
            │   identifier: "canalave-city",         │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 2),             │
            │   identifier: "eterna-city",           │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 3),             │
            │   identifier: "pastoria-city",         │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 4),             │
            │   identifier: "sunyshore-city",        │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPILocation(                       │
            │   id: Tagged(rawValue: 5),             │
            │   identifier: "sinnoh-pokemon-league", │
            │   regionId: Tagged(rawValue: 4)        │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testLocationAreaBasicQuery() {
        Helper.assertQuery(
            PokeAPILocationArea.limit(5)
        ) {
            """
            SELECT "location_areas"."id", "location_areas"."identifier", "location_areas"."location_id", "location_areas"."game_index"
            FROM "location_areas"
            LIMIT 5
            """
        }results: {
            """
            The operation couldn’t be completed. (StructuredQueriesCore.QueryDecodingError error 0.)
            """
        }
    }
    
    @Test
    func testMoveBasicQuery() {
        Helper.assertQuery(
            PokeAPIMove.limit(5)
        ) {
            """
            SELECT "moves"."id", "moves"."identifier", "moves"."generation_id", "moves"."type_id", "moves"."power", "moves"."pp", "moves"."accuracy", "moves"."priority", "moves"."target_id", "moves"."damage_class_id", "moves"."effect_id", "moves"."effect_chance", "moves"."contest_type_id", "moves"."contest_effect_id", "moves"."super_contest_effect_id"
            FROM "moves"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIMove(                          │
            │   id: Tagged(rawValue: 1),            │
            │   identifier: "pound",                │
            │   generationId: Tagged(rawValue: 1),  │
            │   typeId: Tagged(rawValue: 1),        │
            │   power: 40,                          │
            │   pp: 35,                             │
            │   accuracy: 100,                      │
            │   priority: 0,                        │
            │   targetId: 10,                       │
            │   damageClassId: Tagged(rawValue: 2), │
            │   effectId: 1,                        │
            │   effectChance: nil,                  │
            │   contestTypeId: 5,                   │
            │   contestEffectId: 1,                 │
            │   superContestEffectId: 5             │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIMove(                          │
            │   id: Tagged(rawValue: 2),            │
            │   identifier: "karate-chop",          │
            │   generationId: Tagged(rawValue: 1),  │
            │   typeId: Tagged(rawValue: 2),        │
            │   power: 50,                          │
            │   pp: 25,                             │
            │   accuracy: 100,                      │
            │   priority: 0,                        │
            │   targetId: 10,                       │
            │   damageClassId: Tagged(rawValue: 2), │
            │   effectId: 44,                       │
            │   effectChance: nil,                  │
            │   contestTypeId: 5,                   │
            │   contestEffectId: 2,                 │
            │   superContestEffectId: 5             │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIMove(                          │
            │   id: Tagged(rawValue: 3),            │
            │   identifier: "double-slap",          │
            │   generationId: Tagged(rawValue: 1),  │
            │   typeId: Tagged(rawValue: 1),        │
            │   power: 15,                          │
            │   pp: 10,                             │
            │   accuracy: 85,                       │
            │   priority: 0,                        │
            │   targetId: 10,                       │
            │   damageClassId: Tagged(rawValue: 2), │
            │   effectId: 30,                       │
            │   effectChance: nil,                  │
            │   contestTypeId: 5,                   │
            │   contestEffectId: 10,                │
            │   superContestEffectId: 7             │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIMove(                          │
            │   id: Tagged(rawValue: 4),            │
            │   identifier: "comet-punch",          │
            │   generationId: Tagged(rawValue: 1),  │
            │   typeId: Tagged(rawValue: 1),        │
            │   power: 18,                          │
            │   pp: 15,                             │
            │   accuracy: 85,                       │
            │   priority: 0,                        │
            │   targetId: 10,                       │
            │   damageClassId: Tagged(rawValue: 2), │
            │   effectId: 30,                       │
            │   effectChance: nil,                  │
            │   contestTypeId: 5,                   │
            │   contestEffectId: 12,                │
            │   superContestEffectId: 7             │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIMove(                          │
            │   id: Tagged(rawValue: 5),            │
            │   identifier: "mega-punch",           │
            │   generationId: Tagged(rawValue: 1),  │
            │   typeId: Tagged(rawValue: 1),        │
            │   power: 80,                          │
            │   pp: 20,                             │
            │   accuracy: 85,                       │
            │   priority: 0,                        │
            │   targetId: 10,                       │
            │   damageClassId: Tagged(rawValue: 2), │
            │   effectId: 1,                        │
            │   effectChance: nil,                  │
            │   contestTypeId: 5,                   │
            │   contestEffectId: 1,                 │
            │   superContestEffectId: 18            │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testMoveDamageClassBasicQuery() {
        Helper.assertQuery(
            PokeAPIMoveDamageClass.limit(5)
        ) {
            """
            SELECT "move_damage_classes"."id", "move_damage_classes"."identifier"
            FROM "move_damage_classes"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "status"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "physical"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIMoveDamageClass(    │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "special"    │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testMoveTargetBasicQuery() {
        Helper.assertQuery(
            PokeAPIMoveTarget.limit(5)
        ) {
            """
            SELECT "move_targets"."id", "move_targets"."identifier"
            FROM "move_targets"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIMoveTarget(                        │
            │   id: Tagged(rawValue: 1),                │
            │   identifier: "specific-move"             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: Tagged(rawValue: 2),                │
            │   identifier: "selected-pokemon-me-first" │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: Tagged(rawValue: 3),                │
            │   identifier: "ally"                      │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: Tagged(rawValue: 4),                │
            │   identifier: "users-field"               │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: Tagged(rawValue: 5),                │
            │   identifier: "user-or-ally"              │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testNatureBasicQuery() {
        Helper.assertQuery(
            PokeAPINature.limit(5)
        ) {
            """
            SELECT "natures"."id", "natures"."identifier", "natures"."decreased_stat_id", "natures"."increased_stat_id", "natures"."hates_flavor_id", "natures"."likes_flavor_id", "natures"."game_index"
            FROM "natures"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────────┐
            │ PokeAPINature(                          │
            │   id: Tagged(rawValue: 1),              │
            │   identifier: "hardy",                  │
            │   decreasedStatId: Tagged(rawValue: 2), │
            │   increasedStatId: Tagged(rawValue: 2), │
            │   hatesFlavorId: 1,                     │
            │   likesFlavorId: 1,                     │
            │   gameIndex: 0                          │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPINature(                          │
            │   id: Tagged(rawValue: 2),              │
            │   identifier: "bold",                   │
            │   decreasedStatId: Tagged(rawValue: 2), │
            │   increasedStatId: Tagged(rawValue: 3), │
            │   hatesFlavorId: 1,                     │
            │   likesFlavorId: 5,                     │
            │   gameIndex: 5                          │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPINature(                          │
            │   id: Tagged(rawValue: 3),              │
            │   identifier: "modest",                 │
            │   decreasedStatId: Tagged(rawValue: 2), │
            │   increasedStatId: Tagged(rawValue: 4), │
            │   hatesFlavorId: 1,                     │
            │   likesFlavorId: 2,                     │
            │   gameIndex: 15                         │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPINature(                          │
            │   id: Tagged(rawValue: 4),              │
            │   identifier: "calm",                   │
            │   decreasedStatId: Tagged(rawValue: 2), │
            │   increasedStatId: Tagged(rawValue: 5), │
            │   hatesFlavorId: 1,                     │
            │   likesFlavorId: 4,                     │
            │   gameIndex: 20                         │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPINature(                          │
            │   id: Tagged(rawValue: 5),              │
            │   identifier: "timid",                  │
            │   decreasedStatId: Tagged(rawValue: 2), │
            │   increasedStatId: Tagged(rawValue: 6), │
            │   hatesFlavorId: 1,                     │
            │   likesFlavorId: 3,                     │
            │   gameIndex: 10                         │
            │ )                                       │
            └─────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemon.limit(5)
        ) {
            """
            SELECT "pokemon"."id", "pokemon"."identifier", "pokemon"."species_id", "pokemon"."height", "pokemon"."weight", "pokemon"."base_experience", "pokemon"."order", "pokemon"."is_default"
            FROM "pokemon"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 1),        │
            │   identifier: "bulbasaur",        │
            │   speciesId: Tagged(rawValue: 1), │
            │   heightInDecimeters: 7,          │
            │   weightInHectograms: 69,         │
            │   baseExperience: 64,             │
            │   order: 1,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 2),        │
            │   identifier: "ivysaur",          │
            │   speciesId: Tagged(rawValue: 2), │
            │   heightInDecimeters: 10,         │
            │   weightInHectograms: 130,        │
            │   baseExperience: 142,            │
            │   order: 2,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 3),        │
            │   identifier: "venusaur",         │
            │   speciesId: Tagged(rawValue: 3), │
            │   heightInDecimeters: 20,         │
            │   weightInHectograms: 1000,       │
            │   baseExperience: 236,            │
            │   order: 3,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 4),        │
            │   identifier: "charmander",       │
            │   speciesId: Tagged(rawValue: 4), │
            │   heightInDecimeters: 6,          │
            │   weightInHectograms: 85,         │
            │   baseExperience: 62,             │
            │   order: 5,                       │
            │   isDefault: true                 │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemon(                   │
            │   id: Tagged(rawValue: 5),        │
            │   identifier: "charmeleon",       │
            │   speciesId: Tagged(rawValue: 5), │
            │   heightInDecimeters: 11,         │
            │   weightInHectograms: 190,        │
            │   baseExperience: 142,            │
            │   order: 6,                       │
            │   isDefault: true                 │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonAbilityBasicQuery() {
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
    
    @Test
    func testPokemonEvolutionBasicQuery() {
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
            ┌──────────────────────────────────────────┐
            │ PokeAPIPokemonEvolution(                 │
            │   id: Tagged(rawValue: 1),               │
            │   evolvedSpeciesId: Tagged(rawValue: 2), │
            │   evolutionTriggerId: 1,                 │
            │   triggerItemId: nil,                    │
            │   minimumLevel: "16",                    │
            │   genderId: nil,                         │
            │   locationId: nil,                       │
            │   heldItemId: nil,                       │
            │   timeOfDay: nil,                        │
            │   knownMoveId: nil,                      │
            │   knownMoveTypeId: nil,                  │
            │   minimumHappiness: nil,                 │
            │   minimumBeauty: nil,                    │
            │   minimumAffection: nil,                 │
            │   relativePhysicalStats: nil,            │
            │   partySpeciesId: nil,                   │
            │   partyTypeId: nil,                      │
            │   tradeSpeciesId: nil,                   │
            │   needsOverworldRain: false,             │
            │   turnUpsideDown: "0"                    │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonEvolution(                 │
            │   id: Tagged(rawValue: 2),               │
            │   evolvedSpeciesId: Tagged(rawValue: 3), │
            │   evolutionTriggerId: 1,                 │
            │   triggerItemId: nil,                    │
            │   minimumLevel: "32",                    │
            │   genderId: nil,                         │
            │   locationId: nil,                       │
            │   heldItemId: nil,                       │
            │   timeOfDay: nil,                        │
            │   knownMoveId: nil,                      │
            │   knownMoveTypeId: nil,                  │
            │   minimumHappiness: nil,                 │
            │   minimumBeauty: nil,                    │
            │   minimumAffection: nil,                 │
            │   relativePhysicalStats: nil,            │
            │   partySpeciesId: nil,                   │
            │   partyTypeId: nil,                      │
            │   tradeSpeciesId: nil,                   │
            │   needsOverworldRain: false,             │
            │   turnUpsideDown: "0"                    │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonEvolution(                 │
            │   id: Tagged(rawValue: 3),               │
            │   evolvedSpeciesId: Tagged(rawValue: 5), │
            │   evolutionTriggerId: 1,                 │
            │   triggerItemId: nil,                    │
            │   minimumLevel: "16",                    │
            │   genderId: nil,                         │
            │   locationId: nil,                       │
            │   heldItemId: nil,                       │
            │   timeOfDay: nil,                        │
            │   knownMoveId: nil,                      │
            │   knownMoveTypeId: nil,                  │
            │   minimumHappiness: nil,                 │
            │   minimumBeauty: nil,                    │
            │   minimumAffection: nil,                 │
            │   relativePhysicalStats: nil,            │
            │   partySpeciesId: nil,                   │
            │   partyTypeId: nil,                      │
            │   tradeSpeciesId: nil,                   │
            │   needsOverworldRain: false,             │
            │   turnUpsideDown: "0"                    │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonEvolution(                 │
            │   id: Tagged(rawValue: 4),               │
            │   evolvedSpeciesId: Tagged(rawValue: 6), │
            │   evolutionTriggerId: 1,                 │
            │   triggerItemId: nil,                    │
            │   minimumLevel: "36",                    │
            │   genderId: nil,                         │
            │   locationId: nil,                       │
            │   heldItemId: nil,                       │
            │   timeOfDay: nil,                        │
            │   knownMoveId: nil,                      │
            │   knownMoveTypeId: nil,                  │
            │   minimumHappiness: nil,                 │
            │   minimumBeauty: nil,                    │
            │   minimumAffection: nil,                 │
            │   relativePhysicalStats: nil,            │
            │   partySpeciesId: nil,                   │
            │   partyTypeId: nil,                      │
            │   tradeSpeciesId: nil,                   │
            │   needsOverworldRain: false,             │
            │   turnUpsideDown: "0"                    │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonEvolution(                 │
            │   id: Tagged(rawValue: 5),               │
            │   evolvedSpeciesId: Tagged(rawValue: 8), │
            │   evolutionTriggerId: 1,                 │
            │   triggerItemId: nil,                    │
            │   minimumLevel: "16",                    │
            │   genderId: nil,                         │
            │   locationId: nil,                       │
            │   heldItemId: nil,                       │
            │   timeOfDay: nil,                        │
            │   knownMoveId: nil,                      │
            │   knownMoveTypeId: nil,                  │
            │   minimumHappiness: nil,                 │
            │   minimumBeauty: nil,                    │
            │   minimumAffection: nil,                 │
            │   relativePhysicalStats: nil,            │
            │   partySpeciesId: nil,                   │
            │   partyTypeId: nil,                      │
            │   tradeSpeciesId: nil,                   │
            │   needsOverworldRain: false,             │
            │   turnUpsideDown: "0"                    │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonMoveBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonMove.limit(5)
        ) {
            """
            SELECT "pokemon_moves"."pokemon_id", "pokemon_moves"."version_group_id", "pokemon_moves"."move_id", "pokemon_moves"."pokemon_move_method_id", "pokemon_moves"."level", "pokemon_moves"."order", "pokemon_moves"."mastery"
            FROM "pokemon_moves"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPIPokemonMove(                    │
            │   pokemonId: Tagged(rawValue: 1),      │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   moveId: Tagged(rawValue: 33),        │
            │   pokemonMoveMethodId: 1,              │
            │   level: 1,                            │
            │   order: 1,                            │
            │   mastery: nil                         │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokemonMove(                    │
            │   pokemonId: Tagged(rawValue: 1),      │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   moveId: Tagged(rawValue: 45),        │
            │   pokemonMoveMethodId: 1,              │
            │   level: 1,                            │
            │   order: 2,                            │
            │   mastery: nil                         │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokemonMove(                    │
            │   pokemonId: Tagged(rawValue: 1),      │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   moveId: Tagged(rawValue: 73),        │
            │   pokemonMoveMethodId: 1,              │
            │   level: 7,                            │
            │   order: nil,                          │
            │   mastery: nil                         │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokemonMove(                    │
            │   pokemonId: Tagged(rawValue: 1),      │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   moveId: Tagged(rawValue: 22),        │
            │   pokemonMoveMethodId: 1,              │
            │   level: 13,                           │
            │   order: nil,                          │
            │   mastery: nil                         │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokemonMove(                    │
            │   pokemonId: Tagged(rawValue: 1),      │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   moveId: Tagged(rawValue: 77),        │
            │   pokemonMoveMethodId: 1,              │
            │   level: 20,                           │
            │   order: nil,                          │
            │   mastery: nil                         │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonSpeciesBasicQuery() {
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
            │   shapeId: 8,                                │
            │   habitatId: Tagged(rawValue: 3),            │
            │   genderRate: 1,                             │
            │   captureRate: 45,                           │
            │   baseHappiness: 70,                         │
            │   isBaby: false,                             │
            │   hatchCounter: 20,                          │
            │   hasGenderDifferences: false,               │
            │   growthRateId: 4,                           │
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
            │   shapeId: 8,                                │
            │   habitatId: Tagged(rawValue: 3),            │
            │   genderRate: 1,                             │
            │   captureRate: 45,                           │
            │   baseHappiness: 70,                         │
            │   isBaby: false,                             │
            │   hatchCounter: 20,                          │
            │   hasGenderDifferences: false,               │
            │   growthRateId: 4,                           │
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
            │   shapeId: 8,                                │
            │   habitatId: Tagged(rawValue: 3),            │
            │   genderRate: 1,                             │
            │   captureRate: 45,                           │
            │   baseHappiness: 70,                         │
            │   isBaby: false,                             │
            │   hatchCounter: 20,                          │
            │   hasGenderDifferences: true,                │
            │   growthRateId: 4,                           │
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
            │   shapeId: 6,                                │
            │   habitatId: Tagged(rawValue: 4),            │
            │   genderRate: 1,                             │
            │   captureRate: 45,                           │
            │   baseHappiness: 70,                         │
            │   isBaby: false,                             │
            │   hatchCounter: 20,                          │
            │   hasGenderDifferences: false,               │
            │   growthRateId: 4,                           │
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
            │   shapeId: 6,                                │
            │   habitatId: Tagged(rawValue: 4),            │
            │   genderRate: 1,                             │
            │   captureRate: 45,                           │
            │   baseHappiness: 70,                         │
            │   isBaby: false,                             │
            │   hatchCounter: 20,                          │
            │   hasGenderDifferences: false,               │
            │   growthRateId: 4,                           │
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
    
    @Test
    func testPokemonStatBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonStat.limit(5)
        ) {
            """
            SELECT "pokemon_stats"."pokemon_id", "pokemon_stats"."stat_id", "pokemon_stats"."base_stat", "pokemon_stats"."effort"
            FROM "pokemon_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPokemonStat(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   statId: Tagged(rawValue: 1),    │
            │   baseStat: 45,                   │
            │   effort: 0                       │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonStat(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   statId: Tagged(rawValue: 2),    │
            │   baseStat: 49,                   │
            │   effort: 0                       │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonStat(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   statId: Tagged(rawValue: 3),    │
            │   baseStat: 49,                   │
            │   effort: 0                       │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonStat(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   statId: Tagged(rawValue: 4),    │
            │   baseStat: 65,                   │
            │   effort: 1                       │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonStat(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   statId: Tagged(rawValue: 5),    │
            │   baseStat: 65,                   │
            │   effort: 0                       │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonTypeBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonType.limit(5)
        ) {
            """
            SELECT "pokemon_types"."pokemon_id", "pokemon_types"."type_id", "pokemon_types"."slot"
            FROM "pokemon_types"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIPokemonType(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   typeId: Tagged(rawValue: 12),   │
            │   slot: 1                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonType(               │
            │   pokemonId: Tagged(rawValue: 1), │
            │   typeId: Tagged(rawValue: 4),    │
            │   slot: 2                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonType(               │
            │   pokemonId: Tagged(rawValue: 2), │
            │   typeId: Tagged(rawValue: 12),   │
            │   slot: 1                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonType(               │
            │   pokemonId: Tagged(rawValue: 2), │
            │   typeId: Tagged(rawValue: 4),    │
            │   slot: 2                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIPokemonType(               │
            │   pokemonId: Tagged(rawValue: 3), │
            │   typeId: Tagged(rawValue: 12),   │
            │   slot: 1                         │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testRegionBasicQuery() {
        Helper.assertQuery(
            PokeAPIRegion.limit(5)
        ) {
            """
            SELECT "regions"."id", "regions"."identifier"
            FROM "regions"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "kanto"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "johto"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "hoenn"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "sinnoh"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIRegion(             │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "unova"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testStatBasicQuery() {
        Helper.assertQuery(
            PokeAPIStat.limit(5)
        ) {
            """
            SELECT "stats"."id", "stats"."identifier", "stats"."damage_class_id", "stats"."is_battle_only", "stats"."game_index"
            FROM "stats"
            LIMIT 5
            """
        }results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIStat(                          │
            │   id: Tagged(rawValue: 1),            │
            │   identifier: "hp",                   │
            │   damageClassId: nil,                 │
            │   isBattleOnly: false,                │
            │   gameIndex: 1                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIStat(                          │
            │   id: Tagged(rawValue: 2),            │
            │   identifier: "attack",               │
            │   damageClassId: Tagged(rawValue: 2), │
            │   isBattleOnly: false,                │
            │   gameIndex: 2                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIStat(                          │
            │   id: Tagged(rawValue: 3),            │
            │   identifier: "defense",              │
            │   damageClassId: Tagged(rawValue: 2), │
            │   isBattleOnly: false,                │
            │   gameIndex: 3                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIStat(                          │
            │   id: Tagged(rawValue: 4),            │
            │   identifier: "special-attack",       │
            │   damageClassId: Tagged(rawValue: 3), │
            │   isBattleOnly: false,                │
            │   gameIndex: 5                        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIStat(                          │
            │   id: Tagged(rawValue: 5),            │
            │   identifier: "special-defense",      │
            │   damageClassId: Tagged(rawValue: 3), │
            │   isBattleOnly: false,                │
            │   gameIndex: 6                        │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testTypeBasicQuery() {
        Helper.assertQuery(
            PokeAPIType.limit(5)
        ) {
            """
            SELECT "types"."id", "types"."identifier", "types"."generation_id", "types"."damage_class_id"
            FROM "types"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 1),           │
            │   identifier: "normal",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 2),           │
            │   identifier: "fighting",            │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 3),           │
            │   identifier: "flying",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 4),           │
            │   identifier: "poison",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIType(                         │
            │   id: Tagged(rawValue: 5),           │
            │   identifier: "ground",              │
            │   generationId: Tagged(rawValue: 1), │
            │   damageClassId: Tagged(rawValue: 2) │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testTypeEfficacyBasicQuery() {
        Helper.assertQuery(
            PokeAPITypeEfficacy.limit(5)
        ) {
            """
            SELECT "type_efficacy"."damage_type_id", "type_efficacy"."target_type_id", "type_efficacy"."damage_factor"
            FROM "type_efficacy"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 1), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 2), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 3), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 4), │
            │   damageFactor: 100                  │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeEfficacy(                 │
            │   damageTypeId: Tagged(rawValue: 1), │
            │   targetTypeId: Tagged(rawValue: 5), │
            │   damageFactor: 100                  │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testVersionBasicQuery() {
        Helper.assertQuery(
            PokeAPIVersion.limit(5)
        ) {
            """
            SELECT "versions"."id", "versions"."identifier", "versions"."version_group_id"
            FROM "versions"
            LIMIT 5
            """
        }results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 1),            │
            │   identifier: "red",                  │
            │   versionGroupId: Tagged(rawValue: 1) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 2),            │
            │   identifier: "blue",                 │
            │   versionGroupId: Tagged(rawValue: 1) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 3),            │
            │   identifier: "yellow",               │
            │   versionGroupId: Tagged(rawValue: 2) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 4),            │
            │   identifier: "gold",                 │
            │   versionGroupId: Tagged(rawValue: 3) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 5),            │
            │   identifier: "silver",               │
            │   versionGroupId: Tagged(rawValue: 3) │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testVersionGroupBasicQuery() {
        Helper.assertQuery(
            PokeAPIVersionGroup.limit(5)
        ) {
            """
            SELECT "version_groups"."id", "version_groups"."identifier", "version_groups"."generation_id", "version_groups"."order"
            FROM "version_groups"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIVersionGroup(                 │
            │   id: Tagged(rawValue: 1),           │
            │   identifier: "red-blue",            │
            │   generationId: Tagged(rawValue: 1), │
            │   order: 3                           │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIVersionGroup(                 │
            │   id: Tagged(rawValue: 2),           │
            │   identifier: "yellow",              │
            │   generationId: Tagged(rawValue: 1), │
            │   order: 4                           │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIVersionGroup(                 │
            │   id: Tagged(rawValue: 3),           │
            │   identifier: "gold-silver",         │
            │   generationId: Tagged(rawValue: 2), │
            │   order: 5                           │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIVersionGroup(                 │
            │   id: Tagged(rawValue: 4),           │
            │   identifier: "crystal",             │
            │   generationId: Tagged(rawValue: 2), │
            │   order: 6                           │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIVersionGroup(                 │
            │   id: Tagged(rawValue: 5),           │
            │   identifier: "ruby-sapphire",       │
            │   generationId: Tagged(rawValue: 3), │
            │   order: 7                           │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}
