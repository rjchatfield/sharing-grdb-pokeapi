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
                  [0]: "overgrow(slot:1,hidden:false)"
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
        let database = Helper.sqlDB()
        let allPokemonWithEncounters = try PokeAPIPokemon.WithEncounters.fetchAll(database, versionId: 1, limit: 3)
        assertInlineSnapshot(of: allPokemonWithEncounters, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithEncounters(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 16),
                  identifier: "pidgey",
                  speciesId: Tagged(rawValue: 16),
                  heightInDecimeters: 3,
                  weightInHectograms: 18,
                  baseExperience: 50,
                  order: 21,
                  isDefault: true
                ),
                encounters: [
                  [0]: PokeAPIPokemon.WithEncounters.EncounterData(
                    encounter: PokeAPIEncounter(
                      id: Tagged(rawValue: 23999),
                      versionId: Tagged(rawValue: 1),
                      locationAreaId: Tagged(rawValue: 295),
                      encounterSlotId: Tagged(rawValue: 67),
                      pokemonId: Tagged(rawValue: 16),
                      minLevel: 3,
                      maxLevel: 3
                    ),
                    locationArea: PokeAPILocationArea(
                      id: Tagged(rawValue: 295),
                      identifier: nil,
                      locationId: Tagged(rawValue: 88),
                      gameIndex: 112
                    ),
                    minLevel: 3,
                    maxLevel: 3
                  )
                ]
              ),
              [1]: PokeAPIPokemon.WithEncounters(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 19),
                  identifier: "rattata",
                  speciesId: Tagged(rawValue: 19),
                  heightInDecimeters: 3,
                  weightInHectograms: 35,
                  baseExperience: 51,
                  order: 25,
                  isDefault: true
                ),
                encounters: [
                  [0]: PokeAPIPokemon.WithEncounters.EncounterData(
                    encounter: PokeAPIEncounter(
                      id: Tagged(rawValue: 24000),
                      versionId: Tagged(rawValue: 1),
                      locationAreaId: Tagged(rawValue: 295),
                      encounterSlotId: Tagged(rawValue: 68),
                      pokemonId: Tagged(rawValue: 19),
                      minLevel: 3,
                      maxLevel: 3
                    ),
                    locationArea: PokeAPILocationArea(
                      id: Tagged(rawValue: 295),
                      identifier: nil,
                      locationId: Tagged(rawValue: 88),
                      gameIndex: 112
                    ),
                    minLevel: 3,
                    maxLevel: 3
                  ),
                  [1]: PokeAPIPokemon.WithEncounters.EncounterData(
                    encounter: PokeAPIEncounter(
                      id: Tagged(rawValue: 24001),
                      versionId: Tagged(rawValue: 1),
                      locationAreaId: Tagged(rawValue: 295),
                      encounterSlotId: Tagged(rawValue: 69),
                      pokemonId: Tagged(rawValue: 19),
                      minLevel: 3,
                      maxLevel: 3
                    ),
                    locationArea: PokeAPILocationArea(
                      id: Tagged(rawValue: 295),
                      identifier: nil,
                      locationId: Tagged(rawValue: 88),
                      gameIndex: 112
                    ),
                    minLevel: 3,
                    maxLevel: 3
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
              ),
              [2]: PokeAPIPokemon.WithEvolutions(
                pokemon: PokeAPIPokemon(
                  id: Tagged(rawValue: 10033),
                  identifier: "venusaur-mega",
                  speciesId: Tagged(rawValue: 3),
                  heightInDecimeters: 24,
                  weightInHectograms: 1555,
                  baseExperience: 281,
                  order: 4,
                  isDefault: false
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
        assertInlineSnapshot(of: allPokemonWithMoves, as: .customDump) {
            """
            [
              [0]: PokeAPIPokemon.WithMoves(
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
                  [1]: PokeAPIPokemon.WithMoves.MoveData(
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
                  )
                ]
              )
            ]
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
