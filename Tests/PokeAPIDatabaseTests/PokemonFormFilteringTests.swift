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
struct PokemonFormFilteringTests {
    
    @Test func testFormFilteringForGeneration1() throws {
        // Test that Pikachu in Generation 1 (Red/Blue) only returns base form
        let database = Helper.sqlDB()

        let pikachuWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            database, 
            speciesIdentifier: "pikachu", 
            versionId: .red
        )
        
        
        // In Generation 1, Pikachu should only have the base form (no caps, no Gigantamax)
        #expect(pikachuWithAllForms.baseForms.count == 1)
        #expect(pikachuWithAllForms.alternativeForms.count == 0, "Expected 0 alternative forms but got \(pikachuWithAllForms.alternativeForms.count)")
        #expect(pikachuWithAllForms.baseForms.first?.pokemon.identifier == "pikachu")
    }
    
    @Test func testFormFilteringForGeneration6() throws {
        // Test that Charizard in Generation 6 (X/Y) includes Mega forms but not Gigantamax
        let database = Helper.sqlDB()

        let charizardWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            database, 
            speciesIdentifier: "charizard", 
            versionId: .x
        )
        
        let megaForms = charizardWithAllForms.megaForms
        let gigantamaxForms = charizardWithAllForms.gigantamaxForms
        
        // Generation 6 should have Mega forms but not Gigantamax
        #expect(megaForms.count > 0, "Charizard should have Mega forms in Generation 6")
        #expect(gigantamaxForms.count == 0, "Charizard should not have Gigantamax forms in Generation 6")
        
        // Check specific Mega forms
        let megaIdentifiers = megaForms.map(\.pokemon.identifier)
        #expect(megaIdentifiers.contains("charizard-mega-x"), "Should contain Mega Charizard X")
        #expect(megaIdentifiers.contains("charizard-mega-y"), "Should contain Mega Charizard Y")
    }
    
    @Test func testFormFilteringForGeneration8() throws {
        // Test that Charizard in Generation 8 (Sword/Shield) includes Gigantamax but not Mega forms
        let database = Helper.sqlDB()

        let charizardWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            database, 
            speciesIdentifier: "charizard", 
            versionId: .sword
        )
        
        let megaForms = charizardWithAllForms.megaForms
        let gigantamaxForms = charizardWithAllForms.gigantamaxForms
        
        // Generation 8 should have Gigantamax forms but not Mega forms
        #expect(megaForms.count == 0, "Charizard should not have Mega forms in Generation 8")
        #expect(gigantamaxForms.count > 0, "Charizard should have Gigantamax forms in Generation 8")
        
        // Check specific Gigantamax form
        let gigantamaxIdentifiers = gigantamaxForms.map(\.pokemon.identifier)
        #expect(gigantamaxIdentifiers.contains("charizard-gmax"), "Should contain Gigantamax Charizard")
    }
    
    @Test func testRegionalFormsFiltering() throws {
        // Test that regional forms are filtered correctly by generation
        let database = Helper.sqlDB()
        let gen7VersionId = PokeAPIVersion.ID.sun
        let gen8VersionId = PokeAPIVersion.ID.sword

        // Raichu should have Alolan form in Gen 7+
        let raichuGen7 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            database, 
            speciesIdentifier: "raichu", 
            versionId: gen7VersionId
        )
        
        let alolanForms = raichuGen7.alolanForms
        #expect(alolanForms.count > 0, "Raichu should have Alolan forms in Generation 7")
        
        // Meowth should have both Alolan (Gen 7+) and Galarian (Gen 8+) forms in Gen 8
        let meowthGen8 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            database, 
            speciesIdentifier: "meowth", 
            versionId: gen8VersionId
        )
        
        let meowthAlolan = meowthGen8.alolanForms
        let meowthGalarian = meowthGen8.galarianForms
        
        #expect(meowthAlolan.count > 0, "Meowth should have Alolan forms in Generation 8")
        #expect(meowthGalarian.count > 0, "Meowth should have Galarian forms in Generation 8")
    }
    
    @Test func testEvolutionChainFormFiltering() throws {
        // Test that evolution chains properly filter forms by version
        let database = Helper.sqlDB()
        let gen1VersionId = PokeAPIVersion.ID.red
        let gen8VersionId = PokeAPIVersion.ID.sword

        // Get Charizard evolution chain in Gen 1 vs Gen 8
        let charizardGen1Chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            database, 
            pokemonId: PokeAPIPokemon.ID(rawValue: 6), // Charizard ID
            versionId: gen1VersionId
        )
        
        let charizardGen8Chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            database, 
            pokemonId: PokeAPIPokemon.ID(rawValue: 6), // Charizard ID
            versionId: gen8VersionId
        )
        
        // Both should have same number of Pokemon in evolution chain (Charmander -> Charmeleon -> Charizard)
        #expect(charizardGen1Chain.pokemonInChain.count == 3)
        #expect(charizardGen8Chain.pokemonInChain.count == 3)
        
        // But the forms returned should be version-appropriate
        let charizardGen1 = charizardGen1Chain.pokemonInChain.last!
        let charizardGen8 = charizardGen8Chain.pokemonInChain.last!
        
        // Both should use base form (no Mega/Gigantamax in evolution chains)
        #expect(charizardGen1.pokemon.identifier == "charizard")
        #expect(charizardGen8.pokemon.identifier == "charizard")
    }
    
    @Test func testVersionAwareStatsFetching() throws {
        // Test that WithStats.fetchAllForVersion properly filters forms
        let database = Helper.sqlDB()
        let gen1VersionId = PokeAPIVersion.ID.red
        
        let pokemonWithStats = try PokeAPIPokemon.WithStats.fetchAllForVersion(
            database, 
            versionId: gen1VersionId, 
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
    
    

    @Test func testFormFilteringLogic() throws {
        // Test the form filtering logic directly
        let gen1 = 1
        let gen6 = 6  
        let gen7 = 7
        let gen8 = 8
        let gen9 = 9
        
        // Base forms always available
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("pikachu", targetGeneration: gen1))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard", targetGeneration: gen1))
        
        // Mega forms available in Gen 6-7 only
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-x", targetGeneration: gen6))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-y", targetGeneration: gen7))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-x", targetGeneration: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-y", targetGeneration: gen1))
        
        // Gigantamax forms available in Gen 8 only
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", targetGeneration: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", targetGeneration: gen7))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", targetGeneration: gen9))
        
        // Regional forms available from their introduction onwards
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", targetGeneration: gen7))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", targetGeneration: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", targetGeneration: gen6))
        
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", targetGeneration: gen8))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", targetGeneration: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", targetGeneration: gen7))
        
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", targetGeneration: gen8))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", targetGeneration: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", targetGeneration: gen7))
        
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("tauros-paldea-combat-breed", targetGeneration: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("tauros-paldea-combat-breed", targetGeneration: gen8))
        
        // Totem forms available from Gen 7 onwards
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", targetGeneration: gen7))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", targetGeneration: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", targetGeneration: gen6))
    }
}
