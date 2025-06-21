import Testing
import Dependencies
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
@testable import SharingGRDBPokeAPI

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
            ┌───────────────────────────────┐
            │ PokeAPIAbility(               │
            │   id: 1,                      │
            │   identifier: "stench",       │
            │   generationId: 3,            │
            │   isMainSeries: true          │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIAbility(               │
            │   id: 2,                      │
            │   identifier: "drizzle",      │
            │   generationId: 3,            │
            │   isMainSeries: true          │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIAbility(               │
            │   id: 3,                      │
            │   identifier: "speed-boost",  │
            │   generationId: 3,            │
            │   isMainSeries: true          │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIAbility(               │
            │   id: 4,                      │
            │   identifier: "battle-armor", │
            │   generationId: 3,            │
            │   isMainSeries: true          │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIAbility(               │
            │   id: 5,                      │
            │   identifier: "sturdy",       │
            │   generationId: 3,            │
            │   isMainSeries: true          │
            │ )                             │
            └───────────────────────────────┘
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
            ┌──────────────────────────┐
            │ PokeAPIBerry(            │
            │   id: 1,                 │
            │   itemId: 126,           │
            │   firmnessId: 2,         │
            │   naturalGiftPower: 60,  │
            │   naturalGiftTypeId: 10, │
            │   size: 20,              │
            │   maxHarvest: 5,         │
            │   growthTime: 3,         │
            │   soilDryness: 15,       │
            │   smoothness: 25         │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIBerry(            │
            │   id: 2,                 │
            │   itemId: 127,           │
            │   firmnessId: 5,         │
            │   naturalGiftPower: 60,  │
            │   naturalGiftTypeId: 11, │
            │   size: 80,              │
            │   maxHarvest: 5,         │
            │   growthTime: 3,         │
            │   soilDryness: 15,       │
            │   smoothness: 25         │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIBerry(            │
            │   id: 3,                 │
            │   itemId: 128,           │
            │   firmnessId: 1,         │
            │   naturalGiftPower: 60,  │
            │   naturalGiftTypeId: 13, │
            │   size: 40,              │
            │   maxHarvest: 5,         │
            │   growthTime: 3,         │
            │   soilDryness: 15,       │
            │   smoothness: 25         │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIBerry(            │
            │   id: 4,                 │
            │   itemId: 129,           │
            │   firmnessId: 3,         │
            │   naturalGiftPower: 60,  │
            │   naturalGiftTypeId: 12, │
            │   size: 32,              │
            │   maxHarvest: 5,         │
            │   growthTime: 3,         │
            │   soilDryness: 15,       │
            │   smoothness: 25         │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIBerry(            │
            │   id: 5,                 │
            │   itemId: 130,           │
            │   firmnessId: 5,         │
            │   naturalGiftPower: 60,  │
            │   naturalGiftTypeId: 15, │
            │   size: 50,              │
            │   maxHarvest: 5,         │
            │   growthTime: 3,         │
            │   soilDryness: 15,       │
            │   smoothness: 25         │
            │ )                        │
            └──────────────────────────┘
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
            ┌────────────────────────┐
            │ PokeAPIEncounter(      │
            │   id: 1,               │
            │   versionId: 12,       │
            │   locationAreaId: 1,   │
            │   encounterSlotId: 28, │
            │   pokemonId: 72,       │
            │   minLevel: 20,        │
            │   maxLevel: 30         │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIEncounter(      │
            │   id: 2,               │
            │   versionId: 12,       │
            │   locationAreaId: 1,   │
            │   encounterSlotId: 29, │
            │   pokemonId: 278,      │
            │   minLevel: 20,        │
            │   maxLevel: 30         │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIEncounter(      │
            │   id: 3,               │
            │   versionId: 12,       │
            │   locationAreaId: 1,   │
            │   encounterSlotId: 30, │
            │   pokemonId: 73,       │
            │   minLevel: 20,        │
            │   maxLevel: 40         │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIEncounter(      │
            │   id: 4,               │
            │   versionId: 12,       │
            │   locationAreaId: 1,   │
            │   encounterSlotId: 31, │
            │   pokemonId: 279,      │
            │   minLevel: 20,        │
            │   maxLevel: 40         │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIEncounter(      │
            │   id: 5,               │
            │   versionId: 12,       │
            │   locationAreaId: 1,   │
            │   encounterSlotId: 32, │
            │   pokemonId: 279,      │
            │   minLevel: 20,        │
            │   maxLevel: 40         │
            │ )                      │
            └────────────────────────┘
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
            │   id: 1,                   │
            │   identifier: "walk",      │
            │   order: 1                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: 2,                   │
            │   identifier: "old-rod",   │
            │   order: 10                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: 3,                   │
            │   identifier: "good-rod",  │
            │   order: 11                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: 4,                   │
            │   identifier: "super-rod", │
            │   order: 12                │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEncounterMethod(    │
            │   id: 5,                   │
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
            ┌─────────────────────────┐
            │ PokeAPIEncounterSlot(   │
            │   id: 1,                │
            │   versionGroupId: 8,    │
            │   encounterMethodId: 1, │
            │   slot: 1,              │
            │   rarity: 20            │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPIEncounterSlot(   │
            │   id: 2,                │
            │   versionGroupId: 8,    │
            │   encounterMethodId: 1, │
            │   slot: 2,              │
            │   rarity: 20            │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPIEncounterSlot(   │
            │   id: 3,                │
            │   versionGroupId: 8,    │
            │   encounterMethodId: 1, │
            │   slot: 3,              │
            │   rarity: 10            │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPIEncounterSlot(   │
            │   id: 4,                │
            │   versionGroupId: 8,    │
            │   encounterMethodId: 1, │
            │   slot: 4,              │
            │   rarity: 10            │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPIEncounterSlot(   │
            │   id: 5,                │
            │   versionGroupId: 8,    │
            │   encounterMethodId: 1, │
            │   slot: 5,              │
            │   rarity: 10            │
            │ )                       │
            └─────────────────────────┘
            """
        }
    }
    
    @Test
    func testGenerationBasicQuery() {
        Helper.assertQuery(
            PokeAPIGeneration.limit(5)
        ) {
            """
            SELECT "generations"."id", "generations"."main_region_id", "generations"."identifier"
            FROM "generations"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────┐
            │ PokeAPIGeneration(             │
            │   id: 1,                       │
            │   mainRegionId: 1,             │
            │   identifier: "generation-i"   │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIGeneration(             │
            │   id: 2,                       │
            │   mainRegionId: 2,             │
            │   identifier: "generation-ii"  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIGeneration(             │
            │   id: 3,                       │
            │   mainRegionId: 3,             │
            │   identifier: "generation-iii" │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIGeneration(             │
            │   id: 4,                       │
            │   mainRegionId: 4,             │
            │   identifier: "generation-iv"  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIGeneration(             │
            │   id: 5,                       │
            │   mainRegionId: 5,             │
            │   identifier: "generation-v"   │
            │ )                              │
            └────────────────────────────────┘
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
            ┌──────────────────────────────┐
            │ PokeAPIItem(                 │
            │   id: 1,                     │
            │   identifier: "master-ball", │
            │   categoryId: 34,            │
            │   cost: 0,                   │
            │   flingPower: nil,           │
            │   flingEffectId: nil         │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItem(                 │
            │   id: 2,                     │
            │   identifier: "ultra-ball",  │
            │   categoryId: 34,            │
            │   cost: 800,                 │
            │   flingPower: nil,           │
            │   flingEffectId: nil         │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItem(                 │
            │   id: 3,                     │
            │   identifier: "great-ball",  │
            │   categoryId: 34,            │
            │   cost: 600,                 │
            │   flingPower: nil,           │
            │   flingEffectId: nil         │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItem(                 │
            │   id: 4,                     │
            │   identifier: "poke-ball",   │
            │   categoryId: 34,            │
            │   cost: 200,                 │
            │   flingPower: nil,           │
            │   flingEffectId: nil         │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIItem(                 │
            │   id: 5,                     │
            │   identifier: "safari-ball", │
            │   categoryId: 34,            │
            │   cost: 0,                   │
            │   flingPower: nil,           │
            │   flingEffectId: nil         │
            │ )                            │
            └──────────────────────────────┘
            """
        }
    }
    
    @Test
    func testItemCategoryBasicQuery() {
        Helper.assertQuery(
            PokeAPIItemCategory.limit(5)
        ) {
            """
            SELECT "item_categories"."id", "item_categories"."pocket_id", "item_categories"."identifier"
            FROM "item_categories"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────┐
            │ PokeAPIItemCategory(        │
            │   id: 1,                    │
            │   pocketId: 7,              │
            │   identifier: "stat-boosts" │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIItemCategory(        │
            │   id: 2,                    │
            │   pocketId: 5,              │
            │   identifier: "effort-drop" │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIItemCategory(        │
            │   id: 3,                    │
            │   pocketId: 5,              │
            │   identifier: "medicine"    │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIItemCategory(        │
            │   id: 4,                    │
            │   pocketId: 5,              │
            │   identifier: "other"       │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIItemCategory(        │
            │   id: 5,                    │
            │   pocketId: 5,              │
            │   identifier: "in-a-pinch"  │
            │ )                           │
            └─────────────────────────────┘
            """
        }
    }
    
    @Test
    func testLocationBasicQuery() {
        Helper.assertQuery(
            PokeAPILocation.limit(5)
        ) {
            """
            SELECT "locations"."id", "locations"."region_id", "locations"."identifier"
            FROM "locations"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPILocation(                      │
            │   id: 1,                              │
            │   regionId: 4,                        │
            │   identifier: "canalave-city"         │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPILocation(                      │
            │   id: 2,                              │
            │   regionId: 4,                        │
            │   identifier: "eterna-city"           │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPILocation(                      │
            │   id: 3,                              │
            │   regionId: 4,                        │
            │   identifier: "pastoria-city"         │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPILocation(                      │
            │   id: 4,                              │
            │   regionId: 4,                        │
            │   identifier: "sunyshore-city"        │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPILocation(                      │
            │   id: 5,                              │
            │   regionId: 4,                        │
            │   identifier: "sinnoh-pokemon-league" │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testLocationAreaBasicQuery() {
        Helper.assertQuery(
            PokeAPILocationArea.limit(5)
        ) {
            """
            SELECT "location_areas"."id", "location_areas"."location_id", "location_areas"."game_index", "location_areas"."identifier"
            FROM "location_areas"
            LIMIT 5
            """
        } results: {
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
            ┌──────────────────────────────┐
            │ PokeAPIMove(                 │
            │   id: 1,                     │
            │   identifier: "pound",       │
            │   generationId: 1,           │
            │   typeId: 1,                 │
            │   power: 40,                 │
            │   pp: 35,                    │
            │   accuracy: 100,             │
            │   priority: 0,               │
            │   targetId: 10,              │
            │   damageClassId: 2,          │
            │   effectId: 1,               │
            │   effectChance: nil,         │
            │   contestTypeId: 5,          │
            │   contestEffectId: 1,        │
            │   superContestEffectId: 5    │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIMove(                 │
            │   id: 2,                     │
            │   identifier: "karate-chop", │
            │   generationId: 1,           │
            │   typeId: 2,                 │
            │   power: 50,                 │
            │   pp: 25,                    │
            │   accuracy: 100,             │
            │   priority: 0,               │
            │   targetId: 10,              │
            │   damageClassId: 2,          │
            │   effectId: 44,              │
            │   effectChance: nil,         │
            │   contestTypeId: 5,          │
            │   contestEffectId: 2,        │
            │   superContestEffectId: 5    │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIMove(                 │
            │   id: 3,                     │
            │   identifier: "double-slap", │
            │   generationId: 1,           │
            │   typeId: 1,                 │
            │   power: 15,                 │
            │   pp: 10,                    │
            │   accuracy: 85,              │
            │   priority: 0,               │
            │   targetId: 10,              │
            │   damageClassId: 2,          │
            │   effectId: 30,              │
            │   effectChance: nil,         │
            │   contestTypeId: 5,          │
            │   contestEffectId: 10,       │
            │   superContestEffectId: 7    │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIMove(                 │
            │   id: 4,                     │
            │   identifier: "comet-punch", │
            │   generationId: 1,           │
            │   typeId: 1,                 │
            │   power: 18,                 │
            │   pp: 15,                    │
            │   accuracy: 85,              │
            │   priority: 0,               │
            │   targetId: 10,              │
            │   damageClassId: 2,          │
            │   effectId: 30,              │
            │   effectChance: nil,         │
            │   contestTypeId: 5,          │
            │   contestEffectId: 12,       │
            │   superContestEffectId: 7    │
            │ )                            │
            ├──────────────────────────────┤
            │ PokeAPIMove(                 │
            │   id: 5,                     │
            │   identifier: "mega-punch",  │
            │   generationId: 1,           │
            │   typeId: 1,                 │
            │   power: 80,                 │
            │   pp: 20,                    │
            │   accuracy: 85,              │
            │   priority: 0,               │
            │   targetId: 10,              │
            │   damageClassId: 2,          │
            │   effectId: 1,               │
            │   effectChance: nil,         │
            │   contestTypeId: 5,          │
            │   contestEffectId: 1,        │
            │   superContestEffectId: 18   │
            │ )                            │
            └──────────────────────────────┘
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
            ┌──────────────────────────┐
            │ PokeAPIMoveDamageClass(  │
            │   id: 1,                 │
            │   identifier: "status"   │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIMoveDamageClass(  │
            │   id: 2,                 │
            │   identifier: "physical" │
            │ )                        │
            ├──────────────────────────┤
            │ PokeAPIMoveDamageClass(  │
            │   id: 3,                 │
            │   identifier: "special"  │
            │ )                        │
            └──────────────────────────┘
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
            │   id: 1,                                  │
            │   identifier: "specific-move"             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: 2,                                  │
            │   identifier: "selected-pokemon-me-first" │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: 3,                                  │
            │   identifier: "ally"                      │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: 4,                                  │
            │   identifier: "users-field"               │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIMoveTarget(                        │
            │   id: 5,                                  │
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
            ┌─────────────────────────┐
            │ PokeAPINature(          │
            │   id: 1,                │
            │   identifier: "hardy",  │
            │   decreasedStatId: 2,   │
            │   increasedStatId: 2,   │
            │   hatesFlavorId: 1,     │
            │   likesFlavorId: 1,     │
            │   gameIndex: 0          │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPINature(          │
            │   id: 2,                │
            │   identifier: "bold",   │
            │   decreasedStatId: 2,   │
            │   increasedStatId: 3,   │
            │   hatesFlavorId: 1,     │
            │   likesFlavorId: 5,     │
            │   gameIndex: 5          │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPINature(          │
            │   id: 3,                │
            │   identifier: "modest", │
            │   decreasedStatId: 2,   │
            │   increasedStatId: 4,   │
            │   hatesFlavorId: 1,     │
            │   likesFlavorId: 2,     │
            │   gameIndex: 15         │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPINature(          │
            │   id: 4,                │
            │   identifier: "calm",   │
            │   decreasedStatId: 2,   │
            │   increasedStatId: 5,   │
            │   hatesFlavorId: 1,     │
            │   likesFlavorId: 4,     │
            │   gameIndex: 20         │
            │ )                       │
            ├─────────────────────────┤
            │ PokeAPINature(          │
            │   id: 5,                │
            │   identifier: "timid",  │
            │   decreasedStatId: 2,   │
            │   increasedStatId: 6,   │
            │   hatesFlavorId: 1,     │
            │   likesFlavorId: 3,     │
            │   gameIndex: 10         │
            │ )                       │
            └─────────────────────────┘
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
            ┌─────────────────────────────┐
            │ PokeAPIPokemon(             │
            │   id: 1,                    │
            │   identifier: "bulbasaur",  │
            │   speciesId: 1,             │
            │   height: 7,                │
            │   weight: 69,               │
            │   baseExperience: 64,       │
            │   order: 1,                 │
            │   isDefault: true           │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIPokemon(             │
            │   id: 2,                    │
            │   identifier: "ivysaur",    │
            │   speciesId: 2,             │
            │   height: 10,               │
            │   weight: 130,              │
            │   baseExperience: 142,      │
            │   order: 2,                 │
            │   isDefault: true           │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIPokemon(             │
            │   id: 3,                    │
            │   identifier: "venusaur",   │
            │   speciesId: 3,             │
            │   height: 20,               │
            │   weight: 1000,             │
            │   baseExperience: 236,      │
            │   order: 3,                 │
            │   isDefault: true           │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIPokemon(             │
            │   id: 4,                    │
            │   identifier: "charmander", │
            │   speciesId: 4,             │
            │   height: 6,                │
            │   weight: 85,               │
            │   baseExperience: 62,       │
            │   order: 5,                 │
            │   isDefault: true           │
            │ )                           │
            ├─────────────────────────────┤
            │ PokeAPIPokemon(             │
            │   id: 5,                    │
            │   identifier: "charmeleon", │
            │   speciesId: 5,             │
            │   height: 11,               │
            │   weight: 190,              │
            │   baseExperience: 142,      │
            │   order: 6,                 │
            │   isDefault: true           │
            │ )                           │
            └─────────────────────────────┘
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
            ┌────────────────────────┐
            │ PokeAPIPokemonAbility( │
            │   pokemonId: 1,        │
            │   abilityId: 65,       │
            │   isHidden: false,     │
            │   slot: 1              │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIPokemonAbility( │
            │   pokemonId: 1,        │
            │   abilityId: 34,       │
            │   isHidden: true,      │
            │   slot: 3              │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIPokemonAbility( │
            │   pokemonId: 2,        │
            │   abilityId: 65,       │
            │   isHidden: false,     │
            │   slot: 1              │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIPokemonAbility( │
            │   pokemonId: 2,        │
            │   abilityId: 34,       │
            │   isHidden: true,      │
            │   slot: 3              │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIPokemonAbility( │
            │   pokemonId: 3,        │
            │   abilityId: 65,       │
            │   isHidden: false,     │
            │   slot: 1              │
            │ )                      │
            └────────────────────────┘
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
            ┌───────────────────────────────┐
            │ PokeAPIPokemonEvolution(      │
            │   id: 1,                      │
            │   evolvedSpeciesId: 2,        │
            │   evolutionTriggerId: 1,      │
            │   triggerItemId: nil,         │
            │   minimumLevel: "16",         │
            │   genderId: nil,              │
            │   locationId: nil,            │
            │   heldItemId: nil,            │
            │   timeOfDay: nil,             │
            │   knownMoveId: nil,           │
            │   knownMoveTypeId: nil,       │
            │   minimumHappiness: nil,      │
            │   minimumBeauty: nil,         │
            │   minimumAffection: nil,      │
            │   relativePhysicalStats: nil, │
            │   partySpeciesId: nil,        │
            │   partyTypeId: nil,           │
            │   tradeSpeciesId: nil,        │
            │   needsOverworldRain: false,  │
            │   turnUpsideDown: "0"         │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIPokemonEvolution(      │
            │   id: 2,                      │
            │   evolvedSpeciesId: 3,        │
            │   evolutionTriggerId: 1,      │
            │   triggerItemId: nil,         │
            │   minimumLevel: "32",         │
            │   genderId: nil,              │
            │   locationId: nil,            │
            │   heldItemId: nil,            │
            │   timeOfDay: nil,             │
            │   knownMoveId: nil,           │
            │   knownMoveTypeId: nil,       │
            │   minimumHappiness: nil,      │
            │   minimumBeauty: nil,         │
            │   minimumAffection: nil,      │
            │   relativePhysicalStats: nil, │
            │   partySpeciesId: nil,        │
            │   partyTypeId: nil,           │
            │   tradeSpeciesId: nil,        │
            │   needsOverworldRain: false,  │
            │   turnUpsideDown: "0"         │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIPokemonEvolution(      │
            │   id: 3,                      │
            │   evolvedSpeciesId: 5,        │
            │   evolutionTriggerId: 1,      │
            │   triggerItemId: nil,         │
            │   minimumLevel: "16",         │
            │   genderId: nil,              │
            │   locationId: nil,            │
            │   heldItemId: nil,            │
            │   timeOfDay: nil,             │
            │   knownMoveId: nil,           │
            │   knownMoveTypeId: nil,       │
            │   minimumHappiness: nil,      │
            │   minimumBeauty: nil,         │
            │   minimumAffection: nil,      │
            │   relativePhysicalStats: nil, │
            │   partySpeciesId: nil,        │
            │   partyTypeId: nil,           │
            │   tradeSpeciesId: nil,        │
            │   needsOverworldRain: false,  │
            │   turnUpsideDown: "0"         │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIPokemonEvolution(      │
            │   id: 4,                      │
            │   evolvedSpeciesId: 6,        │
            │   evolutionTriggerId: 1,      │
            │   triggerItemId: nil,         │
            │   minimumLevel: "36",         │
            │   genderId: nil,              │
            │   locationId: nil,            │
            │   heldItemId: nil,            │
            │   timeOfDay: nil,             │
            │   knownMoveId: nil,           │
            │   knownMoveTypeId: nil,       │
            │   minimumHappiness: nil,      │
            │   minimumBeauty: nil,         │
            │   minimumAffection: nil,      │
            │   relativePhysicalStats: nil, │
            │   partySpeciesId: nil,        │
            │   partyTypeId: nil,           │
            │   tradeSpeciesId: nil,        │
            │   needsOverworldRain: false,  │
            │   turnUpsideDown: "0"         │
            │ )                             │
            ├───────────────────────────────┤
            │ PokeAPIPokemonEvolution(      │
            │   id: 5,                      │
            │   evolvedSpeciesId: 8,        │
            │   evolutionTriggerId: 1,      │
            │   triggerItemId: nil,         │
            │   minimumLevel: "16",         │
            │   genderId: nil,              │
            │   locationId: nil,            │
            │   heldItemId: nil,            │
            │   timeOfDay: nil,             │
            │   knownMoveId: nil,           │
            │   knownMoveTypeId: nil,       │
            │   minimumHappiness: nil,      │
            │   minimumBeauty: nil,         │
            │   minimumAffection: nil,      │
            │   relativePhysicalStats: nil, │
            │   partySpeciesId: nil,        │
            │   partyTypeId: nil,           │
            │   tradeSpeciesId: nil,        │
            │   needsOverworldRain: false,  │
            │   turnUpsideDown: "0"         │
            │ )                             │
            └───────────────────────────────┘
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
            ┌───────────────────────────┐
            │ PokeAPIPokemonMove(       │
            │   pokemonId: 1,           │
            │   versionGroupId: 1,      │
            │   moveId: 33,             │
            │   pokemonMoveMethodId: 1, │
            │   level: 1,               │
            │   order: 1,               │
            │   mastery: nil            │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIPokemonMove(       │
            │   pokemonId: 1,           │
            │   versionGroupId: 1,      │
            │   moveId: 45,             │
            │   pokemonMoveMethodId: 1, │
            │   level: 1,               │
            │   order: 2,               │
            │   mastery: nil            │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIPokemonMove(       │
            │   pokemonId: 1,           │
            │   versionGroupId: 1,      │
            │   moveId: 73,             │
            │   pokemonMoveMethodId: 1, │
            │   level: 7,               │
            │   order: nil,             │
            │   mastery: nil            │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIPokemonMove(       │
            │   pokemonId: 1,           │
            │   versionGroupId: 1,      │
            │   moveId: 22,             │
            │   pokemonMoveMethodId: 1, │
            │   level: 13,              │
            │   order: nil,             │
            │   mastery: nil            │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIPokemonMove(       │
            │   pokemonId: 1,           │
            │   versionGroupId: 1,      │
            │   moveId: 77,             │
            │   pokemonMoveMethodId: 1, │
            │   level: 20,              │
            │   order: nil,             │
            │   mastery: nil            │
            │ )                         │
            └───────────────────────────┘
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
            ┌────────────────────────────────┐
            │ PokeAPIPokemonSpecies(         │
            │   id: 1,                       │
            │   identifier: "bulbasaur",     │
            │   generationId: 1,             │
            │   evolvesFromSpeciesId: nil,   │
            │   evolutionChainId: 1,         │
            │   colorId: 5,                  │
            │   shapeId: 8,                  │
            │   habitatId: 3,                │
            │   genderRate: 1,               │
            │   captureRate: 45,             │
            │   baseHappiness: 70,           │
            │   isBaby: false,               │
            │   hatchCounter: 20,            │
            │   hasGenderDifferences: false, │
            │   growthRateId: 4,             │
            │   formsSwitchable: false,      │
            │   isLegendary: false,          │
            │   isMythical: false,           │
            │   order: 1,                    │
            │   conquestOrder: nil           │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIPokemonSpecies(         │
            │   id: 2,                       │
            │   identifier: "ivysaur",       │
            │   generationId: 1,             │
            │   evolvesFromSpeciesId: 1,     │
            │   evolutionChainId: 1,         │
            │   colorId: 5,                  │
            │   shapeId: 8,                  │
            │   habitatId: 3,                │
            │   genderRate: 1,               │
            │   captureRate: 45,             │
            │   baseHappiness: 70,           │
            │   isBaby: false,               │
            │   hatchCounter: 20,            │
            │   hasGenderDifferences: false, │
            │   growthRateId: 4,             │
            │   formsSwitchable: false,      │
            │   isLegendary: false,          │
            │   isMythical: false,           │
            │   order: 2,                    │
            │   conquestOrder: nil           │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIPokemonSpecies(         │
            │   id: 3,                       │
            │   identifier: "venusaur",      │
            │   generationId: 1,             │
            │   evolvesFromSpeciesId: 2,     │
            │   evolutionChainId: 1,         │
            │   colorId: 5,                  │
            │   shapeId: 8,                  │
            │   habitatId: 3,                │
            │   genderRate: 1,               │
            │   captureRate: 45,             │
            │   baseHappiness: 70,           │
            │   isBaby: false,               │
            │   hatchCounter: 20,            │
            │   hasGenderDifferences: true,  │
            │   growthRateId: 4,             │
            │   formsSwitchable: true,       │
            │   isLegendary: false,          │
            │   isMythical: false,           │
            │   order: 3,                    │
            │   conquestOrder: nil           │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIPokemonSpecies(         │
            │   id: 4,                       │
            │   identifier: "charmander",    │
            │   generationId: 1,             │
            │   evolvesFromSpeciesId: nil,   │
            │   evolutionChainId: 2,         │
            │   colorId: 8,                  │
            │   shapeId: 6,                  │
            │   habitatId: 4,                │
            │   genderRate: 1,               │
            │   captureRate: 45,             │
            │   baseHappiness: 70,           │
            │   isBaby: false,               │
            │   hatchCounter: 20,            │
            │   hasGenderDifferences: false, │
            │   growthRateId: 4,             │
            │   formsSwitchable: false,      │
            │   isLegendary: false,          │
            │   isMythical: false,           │
            │   order: 4,                    │
            │   conquestOrder: 109           │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIPokemonSpecies(         │
            │   id: 5,                       │
            │   identifier: "charmeleon",    │
            │   generationId: 1,             │
            │   evolvesFromSpeciesId: 4,     │
            │   evolutionChainId: 2,         │
            │   colorId: 8,                  │
            │   shapeId: 6,                  │
            │   habitatId: 4,                │
            │   genderRate: 1,               │
            │   captureRate: 45,             │
            │   baseHappiness: 70,           │
            │   isBaby: false,               │
            │   hatchCounter: 20,            │
            │   hasGenderDifferences: false, │
            │   growthRateId: 4,             │
            │   formsSwitchable: false,      │
            │   isLegendary: false,          │
            │   isMythical: false,           │
            │   order: 5,                    │
            │   conquestOrder: 110           │
            │ )                              │
            └────────────────────────────────┘
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
            ┌─────────────────────┐
            │ PokeAPIPokemonStat( │
            │   pokemonId: 1,     │
            │   statId: 1,        │
            │   baseStat: 45,     │
            │   effort: 0         │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonStat( │
            │   pokemonId: 1,     │
            │   statId: 2,        │
            │   baseStat: 49,     │
            │   effort: 0         │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonStat( │
            │   pokemonId: 1,     │
            │   statId: 3,        │
            │   baseStat: 49,     │
            │   effort: 0         │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonStat( │
            │   pokemonId: 1,     │
            │   statId: 4,        │
            │   baseStat: 65,     │
            │   effort: 1         │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonStat( │
            │   pokemonId: 1,     │
            │   statId: 5,        │
            │   baseStat: 65,     │
            │   effort: 0         │
            │ )                   │
            └─────────────────────┘
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
            ┌─────────────────────┐
            │ PokeAPIPokemonType( │
            │   pokemonId: 1,     │
            │   typeId: 12,       │
            │   slot: 1           │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonType( │
            │   pokemonId: 1,     │
            │   typeId: 4,        │
            │   slot: 2           │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonType( │
            │   pokemonId: 2,     │
            │   typeId: 12,       │
            │   slot: 1           │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonType( │
            │   pokemonId: 2,     │
            │   typeId: 4,        │
            │   slot: 2           │
            │ )                   │
            ├─────────────────────┤
            │ PokeAPIPokemonType( │
            │   pokemonId: 3,     │
            │   typeId: 12,       │
            │   slot: 1           │
            │ )                   │
            └─────────────────────┘
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
            ┌────────────────────────┐
            │ PokeAPIRegion(         │
            │   id: 1,               │
            │   identifier: "kanto"  │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIRegion(         │
            │   id: 2,               │
            │   identifier: "johto"  │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIRegion(         │
            │   id: 3,               │
            │   identifier: "hoenn"  │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIRegion(         │
            │   id: 4,               │
            │   identifier: "sinnoh" │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIRegion(         │
            │   id: 5,               │
            │   identifier: "unova"  │
            │ )                      │
            └────────────────────────┘
            """
        }
    }
    
    @Test
    func testStatBasicQuery() {
        Helper.assertQuery(
            PokeAPIStat.limit(5)
        ) {
            """
            SELECT "stats"."id", "stats"."damage_class_id", "stats"."identifier", "stats"."is_battle_only", "stats"."game_index"
            FROM "stats"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIStat(                     │
            │   id: 1,                         │
            │   damageClassId: nil,            │
            │   identifier: "hp",              │
            │   isBattleOnly: false,           │
            │   gameIndex: 1                   │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIStat(                     │
            │   id: 2,                         │
            │   damageClassId: 2,              │
            │   identifier: "attack",          │
            │   isBattleOnly: false,           │
            │   gameIndex: 2                   │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIStat(                     │
            │   id: 3,                         │
            │   damageClassId: 2,              │
            │   identifier: "defense",         │
            │   isBattleOnly: false,           │
            │   gameIndex: 3                   │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIStat(                     │
            │   id: 4,                         │
            │   damageClassId: 3,              │
            │   identifier: "special-attack",  │
            │   isBattleOnly: false,           │
            │   gameIndex: 5                   │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIStat(                     │
            │   id: 5,                         │
            │   damageClassId: 3,              │
            │   identifier: "special-defense", │
            │   isBattleOnly: false,           │
            │   gameIndex: 6                   │
            │ )                                │
            └──────────────────────────────────┘
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
            ┌───────────────────────────┐
            │ PokeAPIType(              │
            │   id: 1,                  │
            │   identifier: "normal",   │
            │   generationId: 1,        │
            │   damageClassId: 2        │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIType(              │
            │   id: 2,                  │
            │   identifier: "fighting", │
            │   generationId: 1,        │
            │   damageClassId: 2        │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIType(              │
            │   id: 3,                  │
            │   identifier: "flying",   │
            │   generationId: 1,        │
            │   damageClassId: 2        │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIType(              │
            │   id: 4,                  │
            │   identifier: "poison",   │
            │   generationId: 1,        │
            │   damageClassId: 2        │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIType(              │
            │   id: 5,                  │
            │   identifier: "ground",   │
            │   generationId: 1,        │
            │   damageClassId: 2        │
            │ )                         │
            └───────────────────────────┘
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
            ┌──────────────────────┐
            │ PokeAPITypeEfficacy( │
            │   damageTypeId: 1,   │
            │   targetTypeId: 1,   │
            │   damageFactor: 100  │
            │ )                    │
            ├──────────────────────┤
            │ PokeAPITypeEfficacy( │
            │   damageTypeId: 1,   │
            │   targetTypeId: 2,   │
            │   damageFactor: 100  │
            │ )                    │
            ├──────────────────────┤
            │ PokeAPITypeEfficacy( │
            │   damageTypeId: 1,   │
            │   targetTypeId: 3,   │
            │   damageFactor: 100  │
            │ )                    │
            ├──────────────────────┤
            │ PokeAPITypeEfficacy( │
            │   damageTypeId: 1,   │
            │   targetTypeId: 4,   │
            │   damageFactor: 100  │
            │ )                    │
            ├──────────────────────┤
            │ PokeAPITypeEfficacy( │
            │   damageTypeId: 1,   │
            │   targetTypeId: 5,   │
            │   damageFactor: 100  │
            │ )                    │
            └──────────────────────┘
            """
        }
    }
    
    @Test
    func testVersionBasicQuery() {
        Helper.assertQuery(
            PokeAPIVersion.limit(5)
        ) {
            """
            SELECT "versions"."id", "versions"."version_group_id", "versions"."identifier"
            FROM "versions"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────┐
            │ PokeAPIVersion(        │
            │   id: 1,               │
            │   versionGroupId: 1,   │
            │   identifier: "red"    │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIVersion(        │
            │   id: 2,               │
            │   versionGroupId: 1,   │
            │   identifier: "blue"   │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIVersion(        │
            │   id: 3,               │
            │   versionGroupId: 2,   │
            │   identifier: "yellow" │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIVersion(        │
            │   id: 4,               │
            │   versionGroupId: 3,   │
            │   identifier: "gold"   │
            │ )                      │
            ├────────────────────────┤
            │ PokeAPIVersion(        │
            │   id: 5,               │
            │   versionGroupId: 3,   │
            │   identifier: "silver" │
            │ )                      │
            └────────────────────────┘
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
            ┌────────────────────────────────┐
            │ PokeAPIVersionGroup(           │
            │   id: 1,                       │
            │   identifier: "red-blue",      │
            │   generationId: 1,             │
            │   order: 3                     │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIVersionGroup(           │
            │   id: 2,                       │
            │   identifier: "yellow",        │
            │   generationId: 1,             │
            │   order: 4                     │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIVersionGroup(           │
            │   id: 3,                       │
            │   identifier: "gold-silver",   │
            │   generationId: 2,             │
            │   order: 5                     │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIVersionGroup(           │
            │   id: 4,                       │
            │   identifier: "crystal",       │
            │   generationId: 2,             │
            │   order: 6                     │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIVersionGroup(           │
            │   id: 5,                       │
            │   identifier: "ruby-sapphire", │
            │   generationId: 3,             │
            │   order: 7                     │
            │ )                              │
            └────────────────────────────────┘
            """
        }
    }
}
