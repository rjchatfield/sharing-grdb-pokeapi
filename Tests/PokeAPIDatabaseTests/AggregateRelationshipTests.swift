import Testing
import GRDB
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase
import SnapshotTestingCustomDump
import Tagged

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct AggregateRelationshipTests {

    // MARK: - PokeAPIPokemon.WithAbilities

    @Test
    func testPokemonWithAbilities_fetchAll() throws {
        let database = Helper.sqlDB()
        let allPokemonWithAbilities = try PokeAPIPokemon.WithAbilities.fetchAll(database, limit: 3)
        assertInlineSnapshot(of: allPokemonWithAbilities.map { ($0.pokemon.identifier, $0.abilities.map { "\($0.ability.identifier)(slot:\($0.slot),hidden:\($0.isHidden))" }) }, as: .customDump) {
            """
            [
              [0]: (
                "bulbasaur",
                [
                  [0]: "overgrow(slot:1,hidden:false)",
                  [1]: "chlorophyll(slot:3,hidden:true)"
                ]
              ),
              [1]: (
                "ivysaur",
                [
                  [0]: "overgrow(slot:1,hidden:false)",
                  [1]: "chlorophyll(slot:3,hidden:true)"
                ]
              ),
              [2]: (
                "venusaur",
                [
                  [0]: "overgrow(slot:1,hidden:false)",
                  [1]: "chlorophyll(slot:3,hidden:true)"
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithAbilities_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithAbilities = try PokeAPIPokemon.WithAbilities.fetchOne(database, pokemonId: 1)
        assertInlineSnapshot(of: (pokemonWithAbilities.pokemon.identifier, pokemonWithAbilities.abilities.map { "\($0.ability.identifier)(slot:\($0.slot),hidden:\($0.isHidden))" }), as: .customDump) {
            """
            (
              "bulbasaur",
              [
                [0]: "overgrow(slot:1,hidden:false)",
                [1]: "chlorophyll(slot:3,hidden:true)"
              ]
            )
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithEncounters

    @Test
    func testPokemonWithEncounters_fetchAll() throws {
        // TODO: Seems odd that `limit: 3` returned only one result
        let database = Helper.sqlDB()
        let allPokemonWithEncounters = try PokeAPIPokemon.WithEncounters.fetchAll(database, versionId: 1, limit: 3)
        assertInlineSnapshot(of: allPokemonWithEncounters, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithEncounters(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 1),
                  identifier: "bulbasaur",
                  speciesId: Tagged(rawValue: 1),
                  heightInDecimeters: 7,
                  weightInHectograms: 69,
                  baseExperience: 64,
                  order: 1,
                  isDefault: true
                ),
                encounters: [
                  [0]: PokeAPIPokemon.WithEncounters.EncounterData(
                    encounter: PokeAPIEncounter(
                      id: Tagged(rawValue: 50290),
                      versionId: Tagged(rawValue: 1),
                      locationAreaId: Tagged(rawValue: 285),
                      encounterSlotId: Tagged(rawValue: 490),
                      pokemonId: Tagged(rawValue: 1),
                      minLevel: 5,
                      maxLevel: 5
                    ),
                    locationArea: PokeAPILocationArea(
                      id: Tagged(rawValue: 285),
                      identifier: nil,
                      locationId: Tagged(rawValue: 86),
                      gameIndex: 102
                    ),
                    minLevel: 5,
                    maxLevel: 5
                  )
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithEncounters_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithEncounters = try PokeAPIPokemon.WithEncounters.fetchOne(
            database,
            pokemonId: 1, // Bulbasaur
            versionId: 1, // Red version
        )
        assertInlineSnapshot(of: (pokemonWithEncounters.pokemon.identifier, pokemonWithEncounters.encounters.count), as: .customDump) {
            """
            (
              "bulbasaur",
              1
            )
            """
        }
        let pokemonWithEncounters2 = try PokeAPIPokemon.WithEncounters.fetchOne(
            database,
            pokemonId: 10, // Caterpie
            versionId: 1,  // Red version
        )
        assertInlineSnapshot(of: (pokemonWithEncounters2.pokemon.identifier, pokemonWithEncounters2.encounters), as: .customDump) {
            """
            (
              "caterpie",
              [
                [0]: PokeAPIPokemon.WithEncounters.EncounterData(
                  encounter: PokeAPIEncounter(
                    id: Tagged(rawValue: 24258),
                    versionId: Tagged(rawValue: 1),
                    locationAreaId: Tagged(rawValue: 315),
                    encounterSlotId: Tagged(rawValue: 76),
                    pokemonId: Tagged(rawValue: 10),
                    minLevel: 8,
                    maxLevel: 8
                  ),
                  locationArea: PokeAPILocationArea(
                    id: Tagged(rawValue: 315),
                    identifier: nil,
                    locationId: Tagged(rawValue: 104),
                    gameIndex: 132
                  ),
                  minLevel: 8,
                  maxLevel: 8
                ),
                [1]: PokeAPIPokemon.WithEncounters.EncounterData(
                  encounter: PokeAPIEncounter(
                    id: Tagged(rawValue: 24266),
                    versionId: Tagged(rawValue: 1),
                    locationAreaId: Tagged(rawValue: 321),
                    encounterSlotId: Tagged(rawValue: 74),
                    pokemonId: Tagged(rawValue: 10),
                    minLevel: 3,
                    maxLevel: 3
                  ),
                  locationArea: PokeAPILocationArea(
                    id: Tagged(rawValue: 321),
                    identifier: nil,
                    locationId: Tagged(rawValue: 155),
                    gameIndex: 138
                  ),
                  minLevel: 3,
                  maxLevel: 3
                )
              ]
            )
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithEvolutions

    @Test
    func testPokemonWithEvolutions_fetchAll() throws {
        // TODO: Seems odd that `limit: 3` returned only two results
        let database = Helper.sqlDB()
        let allPokemonWithEvolutions = try PokeAPIPokemon.WithEvolutions.fetchAll(database, limit: 3)
        assertInlineSnapshot(of: allPokemonWithEvolutions, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithEvolutions(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 2),
                  identifier: "ivysaur",
                  speciesId: Tagged(rawValue: 2),
                  heightInDecimeters: 10,
                  weightInHectograms: 130,
                  baseExperience: 142,
                  order: 2,
                  isDefault: true
                ),
                evolutions: [
                  [0]: PokeAPIPokemonEvolution(
                    id: Tagged(rawValue: 1),
                    evolvedSpeciesId: Tagged(rawValue: 2),
                    evolutionTriggerId: Tagged(rawValue: 1),
                    triggerItemId: nil,
                    minimumLevel: "16",
                    genderId: nil,
                    locationId: nil,
                    heldItemId: nil,
                    timeOfDay: nil,
                    knownMoveId: nil,
                    knownMoveTypeId: nil,
                    minimumHappiness: nil,
                    minimumBeauty: nil,
                    minimumAffection: nil,
                    relativePhysicalStats: nil,
                    partySpeciesId: nil,
                    partyTypeId: nil,
                    tradeSpeciesId: nil,
                    needsOverworldRain: false,
                    turnUpsideDown: false
                  )
                ]
              ),
              [1]: PokeAPIPokemon.WithEvolutions(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 3),
                  identifier: "venusaur",
                  speciesId: Tagged(rawValue: 3),
                  heightInDecimeters: 20,
                  weightInHectograms: 1000,
                  baseExperience: 236,
                  order: 3,
                  isDefault: true
                ),
                evolutions: [
                  [0]: PokeAPIPokemonEvolution(
                    id: Tagged(rawValue: 2),
                    evolvedSpeciesId: Tagged(rawValue: 3),
                    evolutionTriggerId: Tagged(rawValue: 1),
                    triggerItemId: nil,
                    minimumLevel: "32",
                    genderId: nil,
                    locationId: nil,
                    heldItemId: nil,
                    timeOfDay: nil,
                    knownMoveId: nil,
                    knownMoveTypeId: nil,
                    minimumHappiness: nil,
                    minimumBeauty: nil,
                    minimumAffection: nil,
                    relativePhysicalStats: nil,
                    partySpeciesId: nil,
                    partyTypeId: nil,
                    tradeSpeciesId: nil,
                    needsOverworldRain: false,
                    turnUpsideDown: false
                  )
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithEvolutions_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithEvolutions = try PokeAPIPokemon.WithEvolutions.fetchOne(database, pokemonId: 2)
        assertInlineSnapshot(of: (pokemonWithEvolutions.pokemon.identifier, pokemonWithEvolutions.evolutions.count), as: .customDump) {
            """
            (
              "ivysaur",
              1
            )
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithMoves

    @Test
    func testPokemonWithMoves_fetchAll() throws {
        let database = Helper.sqlDB()
        let allPokemonWithMoves = try PokeAPIPokemon.WithMoves.fetchAll(database, versionGroupId: 1, limit: 2)
        #expect(allPokemonWithMoves.count == 2)
        #expect(allPokemonWithMoves.map(\.moves.count) == [24, 25])
        assertInlineSnapshot(of: allPokemonWithMoves.first, as: .customDump) {
            """
            PokeAPIPokemon.WithMoves(
              pokemon: PokeAPIPokemon(
                id: Tagged(rawValue: 1),
                identifier: "bulbasaur",
                speciesId: Tagged(rawValue: 1),
                heightInDecimeters: 7,
                weightInHectograms: 69,
                baseExperience: 64,
                order: 1,
                isDefault: true
              ),
              moves: [
                [0]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 14),
                    identifier: "swords-dance",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 20,
                    accuracy: nil,
                    priority: 0,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 51,
                    effectChance: nil,
                    contestTypeId: 2,
                    contestEffectId: 32,
                    superContestEffectId: 11
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [1]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 15),
                    identifier: "cut",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 50,
                    pp: 30,
                    accuracy: 95,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 1,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 14,
                    superContestEffectId: 5
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [2]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 34),
                    identifier: "body-slam",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 85,
                    pp: 15,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 7,
                    effectChance: 30,
                    contestTypeId: 5,
                    contestEffectId: 4,
                    superContestEffectId: 5
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [3]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 36),
                    identifier: "take-down",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 90,
                    pp: 20,
                    accuracy: 85,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 49,
                    effectChance: nil,
                    contestTypeId: 5,
                    contestEffectId: 3,
                    superContestEffectId: 5
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [4]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 38),
                    identifier: "double-edge",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 120,
                    pp: 15,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 199,
                    effectChance: nil,
                    contestTypeId: 5,
                    contestEffectId: 3,
                    superContestEffectId: 9
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [5]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 72),
                    identifier: "mega-drain",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: 40,
                    pp: 15,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 3),
                    effectId: 4,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 4,
                    superContestEffectId: 20
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [6]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 76),
                    identifier: "solar-beam",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: 120,
                    pp: 10,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 3),
                    effectId: 152,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 1,
                    superContestEffectId: 6
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [7]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 92),
                    identifier: "toxic",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 4),
                    power: nil,
                    pp: 10,
                    accuracy: 90,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 34,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 33,
                    superContestEffectId: 19
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [8]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 99),
                    identifier: "rage",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 20,
                    pp: 20,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 82,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 17,
                    superContestEffectId: 11
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [9]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 102),
                    identifier: "mimic",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 10,
                    accuracy: nil,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 83,
                    effectChance: nil,
                    contestTypeId: 3,
                    contestEffectId: 19,
                    superContestEffectId: 12
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [10]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 104),
                    identifier: "double-team",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 15,
                    accuracy: nil,
                    priority: 0,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 17,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 16,
                    superContestEffectId: 1
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [11]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 115),
                    identifier: "reflect",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 14),
                    power: nil,
                    pp: 20,
                    accuracy: nil,
                    priority: 0,
                    targetId: 4,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 66,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 15,
                    superContestEffectId: 13
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [12]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 117),
                    identifier: "bide",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 10,
                    accuracy: nil,
                    priority: 1,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 27,
                    effectChance: nil,
                    contestTypeId: 5,
                    contestEffectId: 15,
                    superContestEffectId: 15
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [13]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 156),
                    identifier: "rest",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 14),
                    power: nil,
                    pp: 5,
                    accuracy: nil,
                    priority: 0,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 38,
                    effectChance: nil,
                    contestTypeId: 3,
                    contestEffectId: 16,
                    superContestEffectId: 8
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [14]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 164),
                    identifier: "substitute",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 10,
                    accuracy: nil,
                    priority: 0,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 80,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 16,
                    superContestEffectId: 23
                  ),
                  level: 0,
                  methodId: 4,
                  order: nil,
                  mastery: nil
                ),
                [15]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 33),
                    identifier: "tackle",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: 40,
                    pp: 35,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 1,
                    effectChance: nil,
                    contestTypeId: 5,
                    contestEffectId: 1,
                    superContestEffectId: 5
                  ),
                  level: 1,
                  methodId: 1,
                  order: 1,
                  mastery: nil
                ),
                [16]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 45),
                    identifier: "growl",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 40,
                    accuracy: 100,
                    priority: 0,
                    targetId: 11,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 19,
                    effectChance: nil,
                    contestTypeId: 3,
                    contestEffectId: 28,
                    superContestEffectId: 19
                  ),
                  level: 1,
                  methodId: 1,
                  order: 2,
                  mastery: nil
                ),
                [17]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 73),
                    identifier: "leech-seed",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: nil,
                    pp: 10,
                    accuracy: 90,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 85,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 8,
                    superContestEffectId: 21
                  ),
                  level: 7,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [18]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 22),
                    identifier: "vine-whip",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: 45,
                    pp: 25,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 1,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 1,
                    superContestEffectId: 5
                  ),
                  level: 13,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [19]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 77),
                    identifier: "poison-powder",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 4),
                    power: nil,
                    pp: 35,
                    accuracy: 75,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 67,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 33,
                    superContestEffectId: 19
                  ),
                  level: 20,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [20]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 75),
                    identifier: "razor-leaf",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: 55,
                    pp: 25,
                    accuracy: 95,
                    priority: 0,
                    targetId: 11,
                    damageClassId: Tagged(rawValue: 2),
                    effectId: 44,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 2,
                    superContestEffectId: 5
                  ),
                  level: 27,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [21]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 74),
                    identifier: "growth",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 1),
                    power: nil,
                    pp: 20,
                    accuracy: nil,
                    priority: 0,
                    targetId: 7,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 317,
                    effectChance: nil,
                    contestTypeId: 2,
                    contestEffectId: 32,
                    superContestEffectId: 11
                  ),
                  level: 34,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [22]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 79),
                    identifier: "sleep-powder",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: nil,
                    pp: 15,
                    accuracy: 75,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 1),
                    effectId: 2,
                    effectChance: nil,
                    contestTypeId: 4,
                    contestEffectId: 5,
                    superContestEffectId: 19
                  ),
                  level: 41,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                ),
                [23]: PokeAPIPokemon.WithMoves.MoveData(
                  move: PokeAPIMove(
                    id: Tagged(rawValue: 76),
                    identifier: "solar-beam",
                    generationId: Tagged(rawValue: 1),
                    typeId: Tagged(rawValue: 12),
                    power: 120,
                    pp: 10,
                    accuracy: 100,
                    priority: 0,
                    targetId: 10,
                    damageClassId: Tagged(rawValue: 3),
                    effectId: 152,
                    effectChance: nil,
                    contestTypeId: 1,
                    contestEffectId: 1,
                    superContestEffectId: 6
                  ),
                  level: 48,
                  methodId: 1,
                  order: nil,
                  mastery: nil
                )
              ]
            )
            """
        }
    }

    @Test
    func testPokemonWithMoves_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithMoves = try PokeAPIPokemon.WithMoves.fetchOne(database, pokemonId: 1, versionGroupId: 1)
        assertInlineSnapshot(of: [pokemonWithMoves.pokemon.identifier: pokemonWithMoves.moves.map(\.move.identifier)], as: .customDump) {
            """
            [
              "bulbasaur": [
                [0]: "swords-dance",
                [1]: "cut",
                [2]: "body-slam",
                [3]: "take-down",
                [4]: "double-edge",
                [5]: "mega-drain",
                [6]: "solar-beam",
                [7]: "toxic",
                [8]: "rage",
                [9]: "mimic",
                [10]: "double-team",
                [11]: "reflect",
                [12]: "bide",
                [13]: "rest",
                [14]: "substitute",
                [15]: "tackle",
                [16]: "growl",
                [17]: "leech-seed",
                [18]: "vine-whip",
                [19]: "poison-powder",
                [20]: "razor-leaf",
                [21]: "growth",
                [22]: "sleep-powder",
                [23]: "solar-beam"
              ]
            ]
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithStats

    @Test
    func testPokemonWithStats_fetchAll() throws {
        let database = Helper.sqlDB()
        let allPokemonWithStats = try PokeAPIPokemon.WithStats.fetchAll(database, limit: 2)
        assertInlineSnapshot(of: allPokemonWithStats.map { ($0.pokemon.identifier, $0.stats.map { "\($0.stat.identifier):\($0.baseStat)" }) }, as: .customDump) {
            """
            [
              [0]: (
                "bulbasaur",
                [
                  [0]: "hp:45",
                  [1]: "attack:49",
                  [2]: "defense:49",
                  [3]: "special-attack:65",
                  [4]: "special-defense:65",
                  [5]: "speed:45"
                ]
              ),
              [1]: (
                "ivysaur",
                [
                  [0]: "hp:60",
                  [1]: "attack:62",
                  [2]: "defense:63",
                  [3]: "special-attack:80",
                  [4]: "special-defense:80",
                  [5]: "speed:60"
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithStats_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithStats = try PokeAPIPokemon.WithStats.fetchOne(database, pokemonId: 1)
        assertInlineSnapshot(of: (pokemonWithStats.pokemon.identifier, pokemonWithStats.stats.map { "\($0.stat.identifier):\($0.baseStat)" }), as: .customDump) {
            """
            (
              "bulbasaur",
              [
                [0]: "hp:45",
                [1]: "attack:49",
                [2]: "defense:49",
                [3]: "special-attack:65",
                [4]: "special-defense:65",
                [5]: "speed:45"
              ]
            )
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithTypes

    @Test
    func testPokemonWithTypes_fetchAll() throws {
        let database = Helper.sqlDB()
        let allPokemonWithTypes = try PokeAPIPokemon.WithTypes.fetchAll(database, limit: 5)
        assertInlineSnapshot(of: allPokemonWithTypes, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 1),
                  identifier: "bulbasaur",
                  speciesId: Tagged(rawValue: 1),
                  heightInDecimeters: 7,
                  weightInHectograms: 69,
                  baseExperience: 64,
                  order: 1,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  ),
                  [1]: PokeAPIType(
                    id: Tagged(rawValue: 4),
                    identifier: "poison",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 2)
                  )
                ]
              ),
              [1]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 2),
                  identifier: "ivysaur",
                  speciesId: Tagged(rawValue: 2),
                  heightInDecimeters: 10,
                  weightInHectograms: 130,
                  baseExperience: 142,
                  order: 2,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  ),
                  [1]: PokeAPIType(
                    id: Tagged(rawValue: 4),
                    identifier: "poison",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 2)
                  )
                ]
              ),
              [2]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 3),
                  identifier: "venusaur",
                  speciesId: Tagged(rawValue: 3),
                  heightInDecimeters: 20,
                  weightInHectograms: 1000,
                  baseExperience: 236,
                  order: 3,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 12),
                    identifier: "grass",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  ),
                  [1]: PokeAPIType(
                    id: Tagged(rawValue: 4),
                    identifier: "poison",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 2)
                  )
                ]
              ),
              [3]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 4),
                  identifier: "charmander",
                  speciesId: Tagged(rawValue: 4),
                  heightInDecimeters: 6,
                  weightInHectograms: 85,
                  baseExperience: 62,
                  order: 5,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 10),
                    identifier: "fire",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  )
                ]
              ),
              [4]: PokeAPIPokemon.WithTypes(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 5),
                  identifier: "charmeleon",
                  speciesId: Tagged(rawValue: 5),
                  heightInDecimeters: 11,
                  weightInHectograms: 190,
                  baseExperience: 142,
                  order: 6,
                  isDefault: true
                ),
                types: [
                  [0]: PokeAPIType(
                    id: Tagged(rawValue: 10),
                    identifier: "fire",
                    generationId: Tagged(rawValue: 1),
                    damageClassId: Tagged(rawValue: 3)
                  )
                ]
              )
            ]
            """
        }
    }

    @Test
    func testPokemonWithTypes_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithTypes = try PokeAPIPokemon.WithTypes.fetchOne(database, pokemonId: 1)
        assertInlineSnapshot(of: pokemonWithTypes, as: .customDump) {
            """
            PokeAPIPokemon.WithTypes(
              pokemon: PokeAPIPokemon(
                id: Tagged(rawValue: 1),
                identifier: "bulbasaur",
                speciesId: Tagged(rawValue: 1),
                heightInDecimeters: 7,
                weightInHectograms: 69,
                baseExperience: 64,
                order: 1,
                isDefault: true
              ),
              types: [
                [0]: PokeAPIType(
                  id: Tagged(rawValue: 12),
                  identifier: "grass",
                  generationId: Tagged(rawValue: 1),
                  damageClassId: Tagged(rawValue: 3)
                ),
                [1]: PokeAPIType(
                  id: Tagged(rawValue: 4),
                  identifier: "poison",
                  generationId: Tagged(rawValue: 1),
                  damageClassId: Tagged(rawValue: 2)
                )
              ]
            )
            """
        }
    }
}
