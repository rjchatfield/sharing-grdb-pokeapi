import InlineSnapshotTesting
import PokeAPIDatabase
import Tagged
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithAllFormsTests {
    // MARK: - Form Differences Across Generations

    @Test("Rotom forms were introduced in Gen 4, but form-changing was limited until Gen 5")
    func testRotomFormAvailability() throws {
        // Test Gen 4 version (Diamond/Pearl) - should have base form only initially
        let gen4VersionId = PokeAPIVersion.ID.diamond

        let rotomGen4 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "rotom",
            versionId: gen4VersionId
        )

        // Get all Rotom forms available in Gen 4
        let allRotomFormsGen4 = rotomGen4.baseForms + rotomGen4.alternativeForms
        let rotomIdentifiersGen4 = allRotomFormsGen4.map { $0.pokemon.identifier }

        // Should have multiple Rotom forms in Gen 4
        #expect(allRotomFormsGen4.count > 1, "Rotom should have multiple forms available in Gen 4")
        #expect(rotomIdentifiersGen4.contains("rotom"), "Should contain base Rotom form")

        // Test Gen 8 version - should have all forms available
        let gen8VersionId = PokeAPIVersion.ID.sword

        let rotomGen8 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "rotom",
            versionId: gen8VersionId
        )

        let allRotomFormsGen8 = rotomGen8.baseForms + rotomGen8.alternativeForms
        let rotomIdentifiersGen8 = allRotomFormsGen8.map { $0.pokemon.identifier }

        // Should have same or more forms in Gen 8
        #expect(allRotomFormsGen8.count >= allRotomFormsGen4.count,
                "Gen 8 should have at least as many Rotom forms as Gen 4")

        // Verify specific Rotom forms exist
        let expectedRotomForms = ["rotom", "rotom-heat", "rotom-wash", "rotom-frost", "rotom-fan", "rotom-mow"]
        for expectedForm in expectedRotomForms {
            #expect(rotomIdentifiersGen8.contains(expectedForm),
                    "Gen 8 should contain Rotom form: \(expectedForm)")
        }
    }

    @Test("Test that Pikachu in Generation 1 (Red/Blue) only returns base form")
    func testFormFilteringForGeneration1() throws {
        let pikachuWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "pikachu",
            versionId: .red
        )

        // In Generation 1, Pikachu should only have the base form (no caps, no Gigantamax)
        #expect(pikachuWithAllForms.baseForms.count == 1)
        #expect(pikachuWithAllForms.alternativeForms.count == 0, "Expected 0 alternative forms but got \(pikachuWithAllForms.alternativeForms.count)")
        #expect(pikachuWithAllForms.baseForms.first?.pokemon.identifier == "pikachu")
    }

    @Test("Test that Charizard in Generation 6 (X/Y) includes Mega forms but not Gigantamax")
    func testFormFilteringForGeneration6() throws {
        let charizardWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
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

    @Test("Test that Charizard in Generation 8 (Sword/Shield) includes Gigantamax but not Mega forms")
    func testFormFilteringForGeneration8() throws {
        let charizardWithAllForms = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
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

    @Test("Test that regional forms are filtered correctly by generation")
    func testRegionalFormsFiltering() throws {
        let gen7VersionId = PokeAPIVersion.ID.sun
        let gen8VersionId = PokeAPIVersion.ID.sword

        // Raichu should have Alolan form in Gen 7+
        let raichuGen7 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "raichu",
            versionId: gen7VersionId
        )

        let alolanForms = raichuGen7.alolanForms
        #expect(alolanForms.count > 0, "Raichu should have Alolan forms in Generation 7")

        // Meowth should have both Alolan (Gen 7+) and Galarian (Gen 8+) forms in Gen 8
        let meowthGen8 = try PokeAPIPokemon.WithAllForms.fetchForSpecies(
            .pokeAPI,
            speciesIdentifier: "meowth",
            versionId: gen8VersionId
        )

        let meowthAlolan = meowthGen8.alolanForms
        let meowthGalarian = meowthGen8.galarianForms

        #expect(meowthAlolan.count > 0, "Meowth should have Alolan forms in Generation 8")
        #expect(meowthGalarian.count > 0, "Meowth should have Galarian forms in Generation 8")
    }
}
