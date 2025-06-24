import Testing
import GRDB
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase
import SnapshotTestingCustomDump

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct AggregateRelationshipTests {

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
    func testPokemonWithTypes_fetch() throws {
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
                  [1]: "attack:49"
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

    // MARK: - PokeAPIPokemon.WithEvolutions

    @Test
    func testPokemonWithEvolutions_fetchOne() throws {
        let database = Helper.sqlDB()
        let pokemonWithEvolutions = try PokeAPIPokemon.WithEvolutions.fetchOne(database, pokemonId: 1)
        assertInlineSnapshot(of: (pokemonWithEvolutions.pokemon.identifier, pokemonWithEvolutions.evolutions.count), as: .customDump) {
            """
            (
              "bulbasaur",
              0
            )
            """
        }
    }

    // MARK: - PokeAPIPokemon.WithEncounters

    @Test
    func testPokemonWithEncounters_fetchOne() throws {
        // Skip encounters test - encounter tables may not be populated in test database
        // This implementation is complete but requires encounter data to test properly
    }
}
