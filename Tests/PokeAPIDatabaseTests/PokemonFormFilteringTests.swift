import Testing
import PokeAPIDatabase

@Suite
struct PokemonFormFilteringTests {
    @Test("Test the form filtering logic directly")
    func testFormFilteringLogic() throws {
        let gen1: PokeAPIGeneration.ID = 1
        let gen6: PokeAPIGeneration.ID = 6
        let gen7: PokeAPIGeneration.ID = 7
        let gen8: PokeAPIGeneration.ID = 8
        let gen9: PokeAPIGeneration.ID = 9

        // Base forms always available
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("pikachu", generationId: gen1))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard", generationId: gen1))

        // Mega forms available in Gen 6-7 only
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-x", generationId: gen6))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-y", generationId: gen7))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-x", generationId: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-mega-y", generationId: gen1))

        // Gigantamax forms available in Gen 8 only
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", generationId: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", generationId: gen7))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("charizard-gmax", generationId: gen9))

        // Regional forms available from their introduction onwards
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", generationId: gen7))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", generationId: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raichu-alola", generationId: gen6))

        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", generationId: gen8))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", generationId: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("meowth-galar", generationId: gen7))

        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", generationId: gen8))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", generationId: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("growlithe-hisui", generationId: gen7))

        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("tauros-paldea-combat-breed", generationId: gen9))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("tauros-paldea-combat-breed", generationId: gen8))

        // Totem forms available from Gen 7 onwards
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", generationId: gen7))
        #expect(PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", generationId: gen8))
        #expect(!PokeAPIPokemonFormFiltering.isFormAvailableInGeneration("raticate-totem", generationId: gen6))
    }
}
