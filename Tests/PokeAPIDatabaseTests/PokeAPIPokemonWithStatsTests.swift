import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Tagged
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithStatsTests {
    @Test
    func testFetchAll() throws {
        let allPokemonWithStats = try PokeAPIPokemon.WithStats.fetchAll(.pokeAPI, limit: 2)
        assertInlineSnapshot(of: allPokemonWithStats, as: .customDump) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              ),
              [1]: (
                "Ivysaur",
                stats: [
                  [0]: HP: 60,
                  [1]: Attack: 62,
                  [2]: Defense: 63,
                  [3]: Special Attack: 80,
                  [4]: Special Defense: 80,
                  [5]: Speed: 60
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchAllForVersion() throws {
        // TODO: Generation 1 didn't have "Special" stats
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchAllForVersion(.pokeAPI, generationId: 1, limit: 1),
            as: .customDump
        ) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              )
            ]
            """
        }
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchAllForVersion(.pokeAPI, generationId: 6, limit: 1),
            as: .customDump
        ) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        // TODO: Should handle generationId. Because Generation 1 didn't have "Special" stats
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchOne(.pokeAPI, pokemonId: 1),
            as: .customDump
        ) {
            """
            (
              "Bulbasaur",
              stats: [
                [0]: HP: 45,
                [1]: Attack: 49,
                [2]: Defense: 49,
                [3]: Special Attack: 65,
                [4]: Special Defense: 65,
                [5]: Speed: 45
              ]
            )
            """
        }
    }

    // MARK: - Stat Changes Across Generations

    @Test(
        "Pikachu's Special Attack increased from 50 to 55 in Gen 6",
        .disabled("TODO: Pikachu's Special Attack ignores the Gen change")
    )
    func testPikachuStatChanges() throws {
        // Get Pikachu stats - stats should be consistent across the database
        // as it stores the current canonical stats
        let pikachuWithStats = try PokeAPIPokemon.WithStats.fetchOne(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(25) // Pikachu
        )

        // Verify Pikachu's current stats (Gen 6+ values)

        #expect(pikachuWithStats[.specialAttack] == 55, "Pikachu's Special Attack should be 55 (Gen 6+ value)")
        #expect(pikachuWithStats[.hp] == 35, "Pikachu's HP should remain 35")
        #expect(pikachuWithStats[.attack] == 55, "Pikachu's Attack should remain 55")
        #expect(pikachuWithStats[.defense] == 40, "Pikachu's Defense should remain 40")
        #expect(pikachuWithStats[.speed] == 90, "Pikachu's Speed should remain 90")
    }

    @Test("Crobat has 130 Speed and should have high speed stat")
    func testCrobatStatsConsistency() throws {
        let crobatWithStats = try PokeAPIPokemon.WithStats.fetchOne(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(169) // Crobat
        )

        // Crobat should have 130 Speed as its signature stat
        #expect(crobatWithStats[.speed] == 130, "Crobat's Speed should be 130")

        // Verify other key stats for Crobat
        #expect(crobatWithStats[.hp] == 85, "Crobat's HP should be 85")
        #expect(crobatWithStats[.attack] == 90, "Crobat's Attack should be 90")
    }

    @Test("Alakazam gained significant Special Defense when stats were split in Gen 2")
    func testAlakazamSpecialStats() throws {
        //
        let alakazamWithStats = try PokeAPIPokemon.WithStats.fetchOne(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(65) // Alakazam
        )

        // Alakazam should have very high Special Attack and decent Special Defense
        #expect(alakazamWithStats[.specialAttack] == 135, "Alakazam's Special Attack should be 135")
        #expect(alakazamWithStats[.specialDefense] == 95, "Alakazam's Special Defense should be 95 (post-split value)")

        // Verify Alakazam's notoriously low physical stats
        #expect(alakazamWithStats[.hp] == 55, "Alakazam's HP should be 55")
        #expect(alakazamWithStats[.defense] == 45, "Alakazam's Defense should be 45")
    }

    @Test("Test that WithStats.fetchAllForVersion properly filters forms")
    func testVersionAwareStatsFetching() throws {
        let pokemonWithStats = try PokeAPIPokemon.WithStats.fetchAllForVersion(
            .pokeAPI,
            generationId: 1,
            limit: 200 // Get enough to include some that would have alternate forms
        )

        // No Pokemon should have alternative form identifiers in Generation 1
        for pokemonWithStat in pokemonWithStats {
            let identifier = pokemonWithStat.pokemon.identifier
            #expect(!identifier.contains("-mega"), "No Mega forms should appear in Generation 1: \(identifier)")
            #expect(!identifier.contains("gmax"), "No Gigantamax forms should appear in Generation 1: \(identifier)")
            #expect(!identifier.contains("alola"), "No Alolan forms should appear in Generation 1: \(identifier)")
            #expect(!identifier.contains("galar"), "No Galarian forms should appear in Generation 1: \(identifier)")
        }
    }

    @Test(
        "Test that base stat totals are consistent for base forms",
        .disabled("TODO: Don't handle generation/version. Pikachu and Blastoise has the wrong base stat.")
    )
    func testStateTotalConsistencyForBaseForms() throws {
        // Test some iconic Pokemon with known base stat totals
        let testCases: [(id: PokeAPIPokemon.ID, identifier: PokeAPIPokemon.Identifier, expectedBST: Int)] = [
            (6, "charizard", 534),    // 78/84/78/109/85/100
            (9, "blastoise", 534),    // 79/83/100/85/105/78
            (3, "venusaur", 525),     // 80/82/83/100/100/80
            (25, "pikachu", 320),     // 35/55/40/50/50/90 (Gen 1-5) or 35/55/40/55/50/90 (Gen 6+)
            (150, "mewtwo", 680)      // 106/110/90/154/90/130
        ]

        for testCase in testCases {
            let pokemonWithStats = try PokeAPIPokemon.WithStats.fetchOne(.pokeAPI, pokemonId: testCase.id)
            let totalStats = pokemonWithStats.stats.reduce(into: 0) { sum, stat in sum += stat.baseStat }
            #expect(totalStats == testCase.expectedBST, "\(testCase.identifier) should have BST of \(testCase.expectedBST), got \(totalStats)")
        }
    }
}

// MARK: -

extension PokeAPIPokemon.WithStats: @retroactive CustomDumpRepresentable {
    public var customDumpValue: Any {
        (
            pokemon.localizedName,
            stats: stats
        )
    }
}

extension PokeAPIPokemon.WithStats.StatData: @retroactive CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(stat.localizedName): \(baseStat)"
    }
}
