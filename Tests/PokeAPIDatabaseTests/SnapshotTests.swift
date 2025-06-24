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
            PokeAPIAbility.count()
        ) {
            """
            SELECT count(*)
            FROM "abilities"
            """
        } results: {
            """
            ┌─────┐
            │ 367 │
            └─────┘
            """
        }

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
            PokeAPIBerry.count()
        ) {
            """
            SELECT count(*)
            FROM "berries"
            """
        } results: {
            """
            ┌────┐
            │ 64 │
            └────┘
            """
        }

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
    func testCharacteristicBasicQuery() {
        Helper.assertQuery(
            PokeAPICharacteristic.count()
        ) {
            """
            SELECT count(*)
            FROM "characteristics"
            """
        } results: {
            """
            ┌────┐
            │ 30 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPICharacteristic.limit(5)
        ) {
            """
            SELECT "characteristics"."id", "characteristics"."stat_id", "characteristics"."gene_mod_5"
            FROM "characteristics"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────┐
            │ PokeAPICharacteristic(         │
            │   id: Tagged(rawValue: 1),     │
            │   statId: Tagged(rawValue: 1), │
            │   geneMod5: 0                  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPICharacteristic(         │
            │   id: Tagged(rawValue: 2),     │
            │   statId: Tagged(rawValue: 2), │
            │   geneMod5: 0                  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPICharacteristic(         │
            │   id: Tagged(rawValue: 3),     │
            │   statId: Tagged(rawValue: 3), │
            │   geneMod5: 0                  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPICharacteristic(         │
            │   id: Tagged(rawValue: 4),     │
            │   statId: Tagged(rawValue: 4), │
            │   geneMod5: 0                  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPICharacteristic(         │
            │   id: Tagged(rawValue: 5),     │
            │   statId: Tagged(rawValue: 5), │
            │   geneMod5: 0                  │
            │ )                              │
            └────────────────────────────────┘
            """
        }

        Helper.assertQuery(
            PokeAPICharacteristic
                .where { $0.geneMod5 != 0 }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "characteristics"
            WHERE ("characteristics"."gene_mod_5" <> 0)
            """
        } results: {
            """
            ┌────┐
            │ 24 │
            └────┘
            """
        }
    }
    
    @Test
    func testEggGroupBasicQuery() {
        Helper.assertQuery(
            PokeAPIEggGroup.count()
        ) {
            """
            SELECT count(*)
            FROM "egg_groups"
            """
        } results: {
            """
            ┌────┐
            │ 15 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIEggGroup.limit(5)
        ) {
            """
            SELECT "egg_groups"."id", "egg_groups"."identifier"
            FROM "egg_groups"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEggGroup(           │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "monster"    │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEggGroup(           │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "water1"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEggGroup(           │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "bug"        │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEggGroup(           │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "flying"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEggGroup(           │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "ground"     │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testEncounterBasicQuery() {
        Helper.assertQuery(
            PokeAPIEncounter.count()
        ) {
            """
            SELECT count(*)
            FROM "encounters"
            """
        } results: {
            """
            ┌───────┐
            │ 61519 │
            └───────┘
            """
        }

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
            PokeAPIEncounterMethod.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_methods"
            """
        } results: {
            """
            ┌────┐
            │ 37 │
            └────┘
            """
        }

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
            PokeAPIEncounterSlot.count()
        ) {
            """
            SELECT count(*)
            FROM "encounter_slots"
            """
        } results: {
            """
            ┌──────┐
            │ 1140 │
            └──────┘
            """
        }

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
            PokeAPIEvolutionChain.count()
        ) {
            """
            SELECT count(*)
            FROM "evolution_chains"
            """
        } results: {
            """
            ┌─────┐
            │ 541 │
            └─────┘
            """
        }

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
                .where { $0.babyTriggerItemId != nil }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "evolution_chains"
            WHERE ("evolution_chains"."baby_trigger_item_id" IS NOT NULL)
            """
        } results: {
            """
            ┌───┐
            │ 9 │
            └───┘
            """
        }
    }
    
    @Test
    func testEvolutionTriggerBasicQuery() {
        Helper.assertQuery(
            PokeAPIEvolutionTrigger.count()
        ) {
            """
            SELECT count(*)
            FROM "evolution_triggers"
            """
        } results: {
            """
            ┌────┐
            │ 13 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIEvolutionTrigger.limit(5)
        ) {
            """
            SELECT "evolution_triggers"."id", "evolution_triggers"."identifier"
            FROM "evolution_triggers"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "level-up"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "trade"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "use-item"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "shed"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIEvolutionTrigger(   │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "spin"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testExperienceBasicQuery() {
        Helper.assertQuery(
            PokeAPIExperience.count()
        ) {
            """
            SELECT count(*)
            FROM "experience"
            """
        } results: {
            """
            ┌─────┐
            │ 600 │
            └─────┘
            """
        }

        Helper.assertQuery(
            PokeAPIExperience.limit(5)
        ) {
            """
            SELECT "experience"."growth_rate_id", "experience"."level", "experience"."experience"
            FROM "experience"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIExperience(                   │
            │   growthRateId: Tagged(rawValue: 1), │
            │   level: 1,                          │
            │   experience: 0                      │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIExperience(                   │
            │   growthRateId: Tagged(rawValue: 1), │
            │   level: 2,                          │
            │   experience: 10                     │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIExperience(                   │
            │   growthRateId: Tagged(rawValue: 1), │
            │   level: 3,                          │
            │   experience: 33                     │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIExperience(                   │
            │   growthRateId: Tagged(rawValue: 1), │
            │   level: 4,                          │
            │   experience: 80                     │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIExperience(                   │
            │   growthRateId: Tagged(rawValue: 1), │
            │   level: 5,                          │
            │   experience: 156                    │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testGenerationBasicQuery() {
        Helper.assertQuery(
            PokeAPIGeneration.count()
        ) {
            """
            SELECT count(*)
            FROM "generations"
            """
        } results: {
            """
            ┌───┐
            │ 9 │
            └───┘
            """
        }

        Helper.assertQuery(
            PokeAPIGeneration.limit(5)
        ) {
            """
            SELECT "generations"."id", "generations"."identifier", "generations"."main_region_id"
            FROM "generations"
            LIMIT 5
            """
        } results: {
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
    func testGrowthRateBasicQuery() {
        Helper.assertQuery(
            PokeAPIGrowthRate.count()
        ) {
            """
            SELECT count(*)
            FROM "growth_rates"
            """
        } results: {
            """
            ┌───┐
            │ 6 │
            └───┘
            """
        }

        Helper.assertQuery(
            PokeAPIGrowthRate.limit(5)
        ) {
            """
            SELECT "growth_rates"."id", "growth_rates"."identifier", "growth_rates"."formula"
            FROM "growth_rates"
            LIMIT 5
            """
        } results: {
            #"""
            ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
            │ PokeAPIGrowthRate(                                                                                                                                      │
            │   id: Tagged(rawValue: 1),                                                                                                                              │
            │   identifier: "slow",                                                                                                                                   │
            │   formula: #"\frac{5x^3}{4}"#                                                                                                                           │
            │ )                                                                                                                                                       │
            ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
            │ PokeAPIGrowthRate(                                                                                                                                      │
            │   id: Tagged(rawValue: 2),                                                                                                                              │
            │   identifier: "medium",                                                                                                                                 │
            │   formula: "x^3"                                                                                                                                        │
            │ )                                                                                                                                                       │
            ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
            │ PokeAPIGrowthRate(                                                                                                                                      │
            │   id: Tagged(rawValue: 3),                                                                                                                              │
            │   identifier: "fast",                                                                                                                                   │
            │   formula: #"\frac{4x^3}{5}"#                                                                                                                           │
            │ )                                                                                                                                                       │
            ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
            │ PokeAPIGrowthRate(                                                                                                                                      │
            │   id: Tagged(rawValue: 4),                                                                                                                              │
            │   identifier: "medium-slow",                                                                                                                            │
            │   formula: #"\frac{6x^3}{5} - 15x^2 + 100x - 140"#                                                                                                      │
            │ )                                                                                                                                                       │
            ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
            │ PokeAPIGrowthRate(                                                                                                                                      │
            │   id: Tagged(rawValue: 5),                                                                                                                              │
            │   identifier: "slow-then-very-fast",                                                                                                                    │
            │   formula: """                                                                                                                                          │
            │     \begin{cases}                                                                                                                                       │
            │     \frac{ x^3 \left( 100 - x \right) }{50},    & \text{if } x \leq 50  \\                                                                              │
            │     \frac{ x^3 \left( 150 - x \right) }{100},   & \text{if } 50 < x \leq 68  \\                                                                         │
            │     \frac{ x^3 \left( 1274 + (x \bmod 3)^2 - 9 (x \bmod 3) - 20 \left\lfloor \frac{x}{3} \right\rfloor \right) }{1000}, & \text{if } 68 < x \leq 98  \\ │
            │     \frac{ x^3 \left( 160 - x \right) }{100},   & \text{if } x > 98  \\                                                                                 │
            │     \end{cases}                                                                                                                                         │
            │     """                                                                                                                                                 │
            │ )                                                                                                                                                       │
            └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
            """#
        }
    }
    
    @Test
    func testItemBasicQuery() {
        Helper.assertQuery(
            PokeAPIItem.count()
        ) {
            """
            SELECT count(*)
            FROM "items"
            """
        } results: {
            """
            ┌──────┐
            │ 2180 │
            └──────┘
            """
        }

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

        Helper.assertQuery(
            PokeAPIItem
                .where { $0.flingPower != nil }
                .limit(1)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            WHERE ("items"."fling_power" IS NOT NULL)
            LIMIT 1
            """
        } results: {
            """
            ┌─────────────────────────────────────┐
            │ PokeAPIItem(                        │
            │   id: Tagged(rawValue: 17),         │
            │   identifier: "potion",             │
            │   categoryId: Tagged(rawValue: 27), │
            │   cost: 200,                        │
            │   flingPower: 30,                   │
            │   flingEffectId: nil                │
            │ )                                   │
            └─────────────────────────────────────┘
            """
        }

        Helper.assertQuery(
            PokeAPIItem
                .where { $0.flingEffectId != nil }
                .limit(1)
        ) {
            """
            SELECT "items"."id", "items"."identifier", "items"."category_id", "items"."cost", "items"."fling_power", "items"."fling_effect_id"
            FROM "items"
            WHERE ("items"."fling_effect_id" IS NOT NULL)
            LIMIT 1
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIItem(                       │
            │   id: Tagged(rawValue: 126),       │
            │   identifier: "cheri-berry",       │
            │   categoryId: Tagged(rawValue: 3), │
            │   cost: 80,                        │
            │   flingPower: 10,                  │
            │   flingEffectId: 3                 │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testItemCategoryBasicQuery() {
        Helper.assertQuery(
            PokeAPIItemCategory.count()
        ) {
            """
            SELECT count(*)
            FROM "item_categories"
            """
        } results: {
            """
            ┌────┐
            │ 54 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIItemCategory.limit(5)
        ) {
            """
            SELECT "item_categories"."id", "item_categories"."identifier", "item_categories"."pocket_id"
            FROM "item_categories"
            LIMIT 5
            """
        } results: {
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
            PokeAPILocation.count()
        ) {
            """
            SELECT count(*)
            FROM "locations"
            """
        } results: {
            """
            ┌──────┐
            │ 1070 │
            └──────┘
            """
        }

        Helper.assertQuery(
            PokeAPILocation.limit(5)
        ) {
            """
            SELECT "locations"."id", "locations"."identifier", "locations"."region_id"
            FROM "locations"
            LIMIT 5
            """
        } results: {
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
            PokeAPILocationArea.count()
        ) {
            """
            SELECT count(*)
            FROM "location_areas"
            """
        } results: {
            """
            ┌──────┐
            │ 1089 │
            └──────┘
            """
        }

        Helper.assertQuery(
            PokeAPILocationArea.limit(5)
        ) {
            """
            SELECT "location_areas"."id", "location_areas"."identifier", "location_areas"."location_id", "location_areas"."game_index"
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
    func testMachineBasicQuery() {
        Helper.assertQuery(
            PokeAPIMachine.count()
        ) {
            """
            SELECT count(*)
            FROM "machines"
            """
        } results: {
            """
            ┌──────┐
            │ 2102 │
            └──────┘
            """
        }

        Helper.assertQuery(
            PokeAPIMachine.limit(5)
        ) {
            """
            SELECT "machines"."machine_number", "machines"."version_group_id", "machines"."item_id", "machines"."move_id"
            FROM "machines"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────────┐
            │ PokeAPIMachine(                         │
            │   machineNumber: 0,                     │
            │   versionGroupId: Tagged(rawValue: 20), │
            │   itemId: Tagged(rawValue: 1288),       │
            │   moveId: Tagged(rawValue: 5)           │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIMachine(                         │
            │   machineNumber: 1,                     │
            │   versionGroupId: Tagged(rawValue: 1),  │
            │   itemId: Tagged(rawValue: 305),        │
            │   moveId: Tagged(rawValue: 5)           │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIMachine(                         │
            │   machineNumber: 1,                     │
            │   versionGroupId: Tagged(rawValue: 2),  │
            │   itemId: Tagged(rawValue: 305),        │
            │   moveId: Tagged(rawValue: 5)           │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIMachine(                         │
            │   machineNumber: 1,                     │
            │   versionGroupId: Tagged(rawValue: 3),  │
            │   itemId: Tagged(rawValue: 305),        │
            │   moveId: Tagged(rawValue: 223)         │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIMachine(                         │
            │   machineNumber: 1,                     │
            │   versionGroupId: Tagged(rawValue: 4),  │
            │   itemId: Tagged(rawValue: 305),        │
            │   moveId: Tagged(rawValue: 223)         │
            │ )                                       │
            └─────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testMoveBasicQuery() {
        Helper.assertQuery(
            PokeAPIMove.count()
        ) {
            """
            SELECT count(*)
            FROM "moves"
            """
        } results: {
            """
            ┌─────┐
            │ 937 │
            └─────┘
            """
        }

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

        Helper.assertQuery(
            PokeAPIMove
                .where { $0.effectChance != nil }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "moves"
            WHERE ("moves"."effect_chance" IS NOT NULL)
            """
        } results: {
            """
            ┌─────┐
            │ 218 │
            └─────┘
            """
        }
    }
    
    @Test
    func testMoveDamageClassBasicQuery() {
        Helper.assertQuery(
            PokeAPIMoveDamageClass.count()
        ) {
            """
            SELECT count(*)
            FROM "move_damage_classes"
            """
        } results: {
            """
            ┌───┐
            │ 3 │
            └───┘
            """
        }

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
    func testMoveEffecBasicQuery() {
        Helper.assertQuery(
            PokeAPIMoveEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "move_effects"
            """
        } results: {
            """
            ┌─────┐
            │ 431 │
            └─────┘
            """
        }

        Helper.assertQuery(
            PokeAPIMoveEffect.limit(5)
        ) {
            """
            SELECT "move_effects"."id"
            FROM "move_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────┐
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 1) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 2) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 3) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 4) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 5) │
            │ )                         │
            └───────────────────────────┘
            """
        }
    }
    
    @Test
    func testMoveTargetBasicQuery() {
        Helper.assertQuery(
            PokeAPIMoveTarget.count()
        ) {
            """
            SELECT count(*)
            FROM "move_targets"
            """
        } results: {
            """
            ┌────┐
            │ 16 │
            └────┘
            """
        }

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
            PokeAPINature.count()
        ) {
            """
            SELECT count(*)
            FROM "natures"
            """
        } results: {
            """
            ┌────┐
            │ 25 │
            └────┘
            """
        }

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
    func testPokedexBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokedex.count()
        ) {
            """
            SELECT count(*)
            FROM "pokedexes"
            """
        } results: {
            """
            ┌────┐
            │ 32 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokedex.limit(5)
        ) {
            """
            SELECT "pokedexes"."id", "pokedexes"."identifier", "pokedexes"."region_id", "pokedexes"."is_main_series"
            FROM "pokedexes"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 1),       │
            │   identifier: "national",        │
            │   regionId: nil,                 │
            │   isMainSeries: 1                │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 2),       │
            │   identifier: "kanto",           │
            │   regionId: Tagged(rawValue: 1), │
            │   isMainSeries: 1                │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 3),       │
            │   identifier: "original-johto",  │
            │   regionId: Tagged(rawValue: 2), │
            │   isMainSeries: 1                │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 4),       │
            │   identifier: "hoenn",           │
            │   regionId: Tagged(rawValue: 3), │
            │   isMainSeries: 1                │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 5),       │
            │   identifier: "original-sinnoh", │
            │   regionId: Tagged(rawValue: 4), │
            │   isMainSeries: 1                │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }

    @Test
    func testPokemonBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemon.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon"
            """
        } results: {
            """
            ┌──────┐
            │ 1302 │
            └──────┘
            """
        }

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

        Helper.assertQuery(
            PokeAPIPokemon
                .where { !$0.isDefault }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon"
            WHERE NOT ("pokemon"."is_default")
            """
        } results: {
            """
            ┌─────┐
            │ 276 │
            └─────┘
            """
        }
    }
    
    @Test
    func testPokemonAbilityBasicQuery() {
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
    func testPokemonColorBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonColor.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_colors"
            """
        } results: {
            """
            ┌────┐
            │ 10 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokemonColor.limit(5)
        ) {
            """
            SELECT "pokemon_colors"."id", "pokemon_colors"."identifier"
            FROM "pokemon_colors"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "black"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "blue"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "brown"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "gray"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "green"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonDexNumberBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonDexNumber.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_dex_numbers"
            """
        } results: {
            """
            ┌──────┐
            │ 7412 │
            └──────┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokemonDexNumber.limit(5)
        ) {
            """
            SELECT "pokemon_dex_numbers"."species_id", "pokemon_dex_numbers"."pokedex_id", "pokemon_dex_numbers"."pokedex_number"
            FROM "pokemon_dex_numbers"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 1),  │
            │   pokedexNumber: 1                 │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 2),  │
            │   pokedexNumber: 1                 │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 3),  │
            │   pokedexNumber: 226               │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 7),  │
            │   pokedexNumber: 231               │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonDexNumber(           │
            │   speciesId: Tagged(rawValue: 1),  │
            │   pokedexId: Tagged(rawValue: 12), │
            │   pokedexNumber: 80                │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
    
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
            │   turnUpsideDown: "0"                      │
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
            │   turnUpsideDown: "0"                      │
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
            │   turnUpsideDown: "0"                      │
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
            │   turnUpsideDown: "0"                      │
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
            │   turnUpsideDown: "0"                      │
            │ )                                          │
            └────────────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokeAPIPokemonHabitatBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonHabitat.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_habitats"
            """
        } results: {
            """
            ┌───┐
            │ 9 │
            └───┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokemonHabitat.limit(5)
        ) {
            """
            SELECT "pokemon_habitats"."id", "pokemon_habitats"."identifier"
            FROM "pokemon_habitats"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokemonHabitat(     │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "cave"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonHabitat(     │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "forest"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonHabitat(     │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "grassland"  │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonHabitat(     │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "mountain"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonHabitat(     │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "rare"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonItemBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonItem.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_items"
            """
        } results: {
            """
            ┌──────┐
            │ 5413 │
            └──────┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokemonItem.limit(5)
        ) {
            """
            SELECT "pokemon_items"."pokemon_id", "pokemon_items"."version_id", "pokemon_items"."item_id", "pokemon_items"."rarity"
            FROM "pokemon_items"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPIPokemonItem(                │
            │   pokemonId: Tagged(rawValue: 12), │
            │   versionId: Tagged(rawValue: 7),  │
            │   itemId: Tagged(rawValue: 199),   │
            │   rarity: 5                        │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonItem(                │
            │   pokemonId: Tagged(rawValue: 12), │
            │   versionId: Tagged(rawValue: 8),  │
            │   itemId: Tagged(rawValue: 199),   │
            │   rarity: 5                        │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonItem(                │
            │   pokemonId: Tagged(rawValue: 12), │
            │   versionId: Tagged(rawValue: 9),  │
            │   itemId: Tagged(rawValue: 199),   │
            │   rarity: 5                        │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonItem(                │
            │   pokemonId: Tagged(rawValue: 12), │
            │   versionId: Tagged(rawValue: 10), │
            │   itemId: Tagged(rawValue: 199),   │
            │   rarity: 5                        │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPIPokemonItem(                │
            │   pokemonId: Tagged(rawValue: 12), │
            │   versionId: Tagged(rawValue: 11), │
            │   itemId: Tagged(rawValue: 199),   │
            │   rarity: 5                        │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
    
    @Test
    func testPokemonMoveBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonMove.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_moves"
            """
        } results: {
            """
            ┌────────┐
            │ 609926 │
            └────────┘
            """
        }

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
    func testPokemonShapeBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonShape.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_shapes"
            """
        } results: {
            """
            ┌────┐
            │ 14 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIPokemonShape.limit(5)
        ) {
            """
            SELECT "pokemon_shapes"."id", "pokemon_shapes"."identifier"
            FROM "pokemon_shapes"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "ball"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "squiggle"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "fish"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "arms"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "blob"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }

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
    
    @Test
    func testPokemonStatBasicQuery() {
        Helper.assertQuery(
            PokeAPIPokemonStat.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_stats"
            """
        } results: {
            """
            ┌──────┐
            │ 7812 │
            └──────┘
            """
        }

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
            PokeAPIPokemonType.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_types"
            """
        } results: {
            """
            ┌──────┐
            │ 2028 │
            └──────┘
            """
        }

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
            PokeAPIRegion.count()
        ) {
            """
            SELECT count(*)
            FROM "regions"
            """
        } results: {
            """
            ┌────┐
            │ 10 │
            └────┘
            """
        }

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
            PokeAPIStat.count()
        ) {
            """
            SELECT count(*)
            FROM "stats"
            """
        } results: {
            """
            ┌───┐
            │ 8 │
            └───┘
            """
        }

        Helper.assertQuery(
            PokeAPIStat.limit(5)
        ) {
            """
            SELECT "stats"."id", "stats"."identifier", "stats"."damage_class_id", "stats"."is_battle_only", "stats"."game_index"
            FROM "stats"
            LIMIT 5
            """
        } results: {
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
            PokeAPIType.count()
        ) {
            """
            SELECT count(*)
            FROM "types"
            """
        } results: {
            """
            ┌────┐
            │ 21 │
            └────┘
            """
        }

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
            PokeAPITypeEfficacy.count()
        ) {
            """
            SELECT count(*)
            FROM "type_efficacy"
            """
        } results: {
            """
            ┌─────┐
            │ 324 │
            └─────┘
            """
        }

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
            PokeAPIVersion.count()
        ) {
            """
            SELECT count(*)
            FROM "versions"
            """
        } results: {
            """
            ┌────┐
            │ 46 │
            └────┘
            """
        }

        Helper.assertQuery(
            PokeAPIVersion.limit(5)
        ) {
            """
            SELECT "versions"."id", "versions"."identifier", "versions"."version_group_id"
            FROM "versions"
            LIMIT 5
            """
        } results: {
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
            PokeAPIVersionGroup.count()
        ) {
            """
            SELECT count(*)
            FROM "version_groups"
            """
        } results: {
            """
            ┌────┐
            │ 29 │
            └────┘
            """
        }

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
