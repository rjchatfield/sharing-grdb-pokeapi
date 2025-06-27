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
struct PokemonWithEvolutionChainTests {

    // MARK: - PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_charmanderEvolutionLine() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        
        // Verify we get the complete Charmander evolution line in natural order
        let pokemonNames = chain.pokemonInChain.map(\.species.identifier)
        assertInlineSnapshot(of: pokemonNames, as: .customDump) {
            """
            [
              [0]: "charmander",
              [1]: "charmeleon",
              [2]: "charizard"
            ]
            """
        }
        
        // Verify they all belong to the same evolution chain
        let uniqueChainIds = Set(chain.pokemonInChain.map(\.species.evolutionChainId))
        #expect(uniqueChainIds.count == 1)
        #expect(uniqueChainIds.first == chain.chainId)
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_charmanderEvolutionLine_pokemonX() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .x
        )
        
        // Verify we get the complete Charmander evolution line in Pokemon X (may include Mega forms)
        let pokemonNames = chain.pokemonInChain.map(\.species.identifier)
        assertInlineSnapshot(of: pokemonNames, as: .customDump) {
            """
            [
              [0]: "charmander",
              [1]: "charmeleon",
              [2]: "charizard"
            ]
            """
        }
        
        // Check if there are any special Charizard forms (Mega, Gigantamax) in the Pokemon data
        let pokemonIdentifiers = chain.pokemonInChain.map(\.pokemon.identifier)
        let specialForms = pokemonIdentifiers.filter { 
            $0.contains("mega") || $0.contains("gmax") || $0.contains("charizard-mega") || $0.contains("charizard-gmax")
        }
        
        // Log what we found for debugging
        print("Pokemon X Charmander chain identifiers: \(pokemonIdentifiers)")
        print("Special forms found: \(specialForms)")
        
        // Verify they all belong to the same evolution chain
        let uniqueChainIds = Set(chain.pokemonInChain.map(\.species.evolutionChainId))
        #expect(uniqueChainIds.count == 1)
        #expect(uniqueChainIds.first == chain.chainId)
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_charmanderEvolutionLine_pokemonSword() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .sword
        )
        
        // Verify we get the complete Charmander evolution line in Pokemon Sword (may include Gigantamax forms)
        let pokemonNames = chain.pokemonInChain.map(\.species.identifier)
        assertInlineSnapshot(of: pokemonNames, as: .customDump) {
            """
            [
              [0]: "charmander",
              [1]: "charmeleon",
              [2]: "charizard"
            ]
            """
        }
        
        // Check if there are any special Charizard forms (Mega, Gigantamax) in the Pokemon data
        let pokemonIdentifiers = chain.pokemonInChain.map(\.pokemon.identifier)
        let specialForms = pokemonIdentifiers.filter { 
            $0.contains("mega") || $0.contains("gmax") || $0.contains("charizard-mega") || $0.contains("charizard-gmax")
        }
        
        // Log what we found for debugging
        print("Pokemon Sword Charmander chain identifiers: \(pokemonIdentifiers)")
        print("Special forms found: \(specialForms)")
        
        // Check if Gigantamax Charizard appears (it should since this is Sword/Shield where G-Max was introduced)
        let hasGigantamax = pokemonIdentifiers.contains { $0.contains("gmax") }
        print("Has Gigantamax form: \(hasGigantamax)")
        
        // Verify they all belong to the same evolution chain
        let uniqueChainIds = Set(chain.pokemonInChain.map(\.species.evolutionChainId))
        #expect(uniqueChainIds.count == 1)
        #expect(uniqueChainIds.first == chain.chainId)
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_bulbasaurEvolutionLine() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(1), // Bulbasaur
            versionId: .red
        )
        
        // Verify we get the complete Bulbasaur evolution line in natural order
        let pokemonNames = chain.pokemonInChain.map(\.species.identifier)
        assertInlineSnapshot(of: pokemonNames, as: .customDump) {
            """
            [
              [0]: "bulbasaur",
              [1]: "ivysaur",
              [2]: "venusaur"
            ]
            """
        }
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_startingFromMiddleEvolution() throws {
        // Start with Charmeleon (middle evolution) and verify we get the complete chain
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(5), // Charmeleon
            versionId: .red
        )
        
        // Should still get the complete Charmander line in natural order
        let pokemonNames = chain.pokemonInChain.map(\.species.identifier)
        assertInlineSnapshot(of: pokemonNames, as: .customDump) {
            """
            [
              [0]: "charmander",
              [1]: "charmeleon",
              [2]: "charizard"
            ]
            """
        }
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_pokemonWithStats() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        
        // Verify each Pokemon has exactly 6 stats
        for pokemonData in chain.pokemonInChain {
            #expect(pokemonData.stats.count == 6, "Pokemon \(pokemonData.species.identifier) should have 6 stats")
            
            // Verify stat names are as expected
            let statNames = pokemonData.stats.map(\.stat.identifier)
            #expect(statNames.contains(.hp))
            #expect(statNames.contains(.attack))
            #expect(statNames.contains(.defense))
            #expect(statNames.contains(.specialAttack))
            #expect(statNames.contains(.specialDefense))
            #expect(statNames.contains(.speed))
        }
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_totalStatsCalculation() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        
        // Find Charmander and Charizard in the chain
        guard let charmander = chain.pokemonInChain.first(where: { $0.species.identifier == "charmander" }),
              let charizard = chain.pokemonInChain.first(where: { $0.species.identifier == "charizard" }) else {
            throw TestError.pokemonNotFound
        }
        
        // Charizard should have higher total stats than Charmander
        #expect(charizard.totalStats > charmander.totalStats, 
               "Charizard (\(charizard.totalStats)) should have higher total stats than Charmander (\(charmander.totalStats))")
        
        // Verify maxTotalStats returns the highest value
        #expect(chain.maxTotalStats == charizard.totalStats)
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_strongestPokemon() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        
        // The strongest Pokemon should be Charizard (final evolution)
        guard let strongest = chain.strongestPokemon else {
            throw TestError.noStrongestPokemon
        }
        
        #expect(strongest.species.identifier == "charizard")
        #expect(strongest.totalStats == chain.maxTotalStats)
    }

    @Test
    func testWithEvolutionChain_fetchChainForPokemon_nonExistentPokemon() throws {
        // Test with a Pokemon ID that doesn't exist
        #expect(throws: Error.self) {
            _ = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
                .pokeAPI,
                pokemonId: PokeAPIPokemon.ID(99999),
                versionId: .red
            )
        }
    }

    // MARK: - PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion

    @Test
    func testWithEvolutionChain_fetchAllForVersion_redVersion() throws {
        let chains = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(
            .pokeAPI,
            versionId: .red,
            limit: 5 // Just test first 5 chains
        )
        
        #expect(chains.count == 5)
        
        // Verify chains are sorted by strongest Pokemon (descending)
        for i in 0..<(chains.count - 1) {
            #expect(chains[i].maxTotalStats >= chains[i + 1].maxTotalStats,
                   "Chains should be sorted by max total stats (strongest first)")
        }
    }

    @Test
    func testWithEvolutionChain_fetchAllForVersion_chainContainsMultiplePokemon() throws {
        let chains = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(
            .pokeAPI,
            versionId: .red,
            limit: 10
        )
        
        // Find a chain with multiple evolutions (like starter chains)
        let multiEvolutionChain = chains.first { $0.pokemonInChain.count > 1 }
        
        #expect(multiEvolutionChain != nil, "Should find at least one evolution chain with multiple Pokemon")
        
        if let chain = multiEvolutionChain {
            // All Pokemon in the chain should share the same evolution chain ID
            let chainIds = Set(chain.pokemonInChain.map(\.species.evolutionChainId))
            #expect(chainIds.count == 1, "All Pokemon in chain should share same evolution chain ID")
            #expect(chainIds.first == chain.chainId)
        }
    }

    @Test
    func testWithEvolutionChain_fetchAllForVersion_withLimit() throws {
        // Test with different limits
        let chains3 = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(
            .pokeAPI,
            versionId: .red,
            limit: 3
        )
        let chains10 = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(
            .pokeAPI,
            versionId: .red,
            limit: 10
        )
        
        #expect(chains3.count == 3)
        #expect(chains10.count == 10)
        #expect(chains10.count > chains3.count)
    }

    @Test
    func testWithEvolutionChain_fetchAllForVersion_catchablePokemon() throws {
        let chains = try PokeAPIPokemon.WithEvolutionChain.fetchAllForVersion(
            .pokeAPI,
            versionId: .red,
            limit: 5
        )
        
        // Check that at least some chains have catchable Pokemon
        let chainsWithCatchablePokemon = chains.filter { !$0.catchablePokemon.isEmpty }
        
        #expect(!chainsWithCatchablePokemon.isEmpty, "Some chains should have Pokemon catchable in the wild")
        
        // Verify catchablePokemon only includes Pokemon with encounters
        for chain in chainsWithCatchablePokemon {
            for pokemon in chain.catchablePokemon {
                #expect(!pokemon.encounters.isEmpty, 
                       "\(pokemon.species.identifier) in catchablePokemon should have encounters")
            }
        }
    }

    // MARK: - Edge Cases and Data Validation

    @Test
    func testWithEvolutionChain_dataIntegrity() throws {
        let chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        
        // Verify data integrity
        for pokemonData in chain.pokemonInChain {
            // Pokemon and species should be related
            #expect(pokemonData.pokemon.speciesId == pokemonData.species.id)
            
            // Stats should have valid values
            for stat in pokemonData.stats {
                #expect(stat.baseStat >= 0, "Base stat should be non-negative")
                #expect(stat.effort >= 0, "Effort yield should be non-negative")
            }
            
            // Encounters should have valid level ranges
            for encounter in pokemonData.encounters {
                #expect(encounter.minLevel > 0, "Min level should be positive")
                #expect(encounter.maxLevel >= encounter.minLevel, "Max level should be >= min level")
                #expect(encounter.rarity >= 0, "Rarity should be non-negative")
            }
        }
    }

    @Test
    func testWithEvolutionChain_pokemonOrderConsistency() throws {
        // Fetch the same chain multiple times and verify consistent ordering
        let chain1 = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(4), // Charmander
            versionId: .red
        )
        let chain2 = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(5), // Charmeleon (same chain)
            versionId: .red
        )
        
        // Both should return the same Pokemon in the same order
        let names1 = chain1.pokemonInChain.map(\.species.identifier)
        let names2 = chain2.pokemonInChain.map(\.species.identifier)
        
        #expect(names1 == names2, "Same evolution chain should return Pokemon in consistent order")
    }

    // MARK: - Pokemon Forms Tests

    @Test
    func testWithAllForms_charizardInPokemonX() throws {
        let charizardForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "charizard",
            versionId: .x
        )
        
        // Should have base Charizard
        #expect(charizardForms.baseForms.count == 1)
        #expect(charizardForms.baseForms.first?.pokemon.identifier == "charizard")
        
        // Check all forms available
        let allFormIdentifiers = charizardForms.allForms.map(\.pokemon.identifier).sorted()
        print("Charizard forms in Pokemon X: \(allFormIdentifiers)")
        
        // Check for Mega forms specifically
        let megaFormIdentifiers = charizardForms.megaForms.map(\.pokemon.identifier)
        print("Mega Charizard forms: \(megaFormIdentifiers)")
        
        // Check for Gigantamax forms
        let gigantamaxFormIdentifiers = charizardForms.gigantamaxForms.map(\.pokemon.identifier)
        print("Gigantamax Charizard forms: \(gigantamaxFormIdentifiers)")
        
        // Verify species consistency
        for form in charizardForms.allForms {
            #expect(form.pokemon.speciesId == charizardForms.species.id)
        }
    }

    @Test
    func testWithAllForms_charizardInPokemonSword() throws {
        let charizardForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "charizard",
            versionId: .sword
        )
        
        // Check all forms available
        let allFormIdentifiers = charizardForms.allForms.map(\.pokemon.identifier).sorted()
        print("Charizard forms in Pokemon Sword: \(allFormIdentifiers)")
        
        // Check stats differences between forms
        if let baseCharizard = charizardForms.baseForms.first,
           let strongestForm = charizardForms.strongestForm {
            print("Base Charizard total stats: \(baseCharizard.totalStats)")
            print("Strongest form (\(strongestForm.pokemon.identifier)) total stats: \(strongestForm.totalStats)")
        }
    }

    @Test
    func testWithAllForms_formCategorization() throws {
        // Test Pikachu (has many form types)
        let pikachuForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "pikachu",
            versionId: .sword
        )
        
        print("Pikachu forms in Sword: \(pikachuForms.allForms.map(\.pokemon.identifier))")
        print("Available categories: \(pikachuForms.availableCategories.map(\.rawValue))")
        
        // Test category filtering
        let costumeForms = pikachuForms.costumeForms
        let gigantamaxForms = pikachuForms.gigantamaxForms
        
        print("Costume forms: \(costumeForms.map(\.pokemon.identifier))")
        print("Gigantamax forms: \(gigantamaxForms.map(\.pokemon.identifier))")
        
        // Verify categorization works
        for form in pikachuForms.allForms {
            let category = form.formCategory
            print("Form: \(form.pokemon.identifier) -> Category: \(category.rawValue)")
        }
        
        // Test that at least some forms are properly categorized
        #expect(!pikachuForms.allForms.isEmpty)
    }

    @Test 
    func testWithAllForms_regionalVariants() throws {
        // Test Pokemon with regional variants
        let vulpixForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "vulpix",
            versionId: .sun // Pokemon Sun (Gen 7, has Alolan forms)
        )
        
        print("Vulpix forms in Sun: \(vulpixForms.allForms.map(\.pokemon.identifier))")
        print("Regional variants: \(vulpixForms.regionalVariants.map(\.pokemon.identifier))")
        print("Alolan forms: \(vulpixForms.alolanForms.map(\.pokemon.identifier))")
        
        // Should have base Vulpix and Alolan Vulpix
        #expect(vulpixForms.baseForms.count >= 1)
        #expect(vulpixForms.alolanForms.count >= 1)
    }

    // MARK: - Helper Types

    enum TestError: Error {
        case pokemonNotFound
        case noStrongestPokemon
    }
}
