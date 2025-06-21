import Testing
import PokeAPIDatabase

@Suite("PokeAPI Strings Localization Tests")
struct PokeAPIStringsTests {
    @Test("Pokemon localization")
    func testPokemonLocalization() {
        #expect(PokeAPIStrings.pokemon(id: 25) == "Pikachu")
        #expect(PokeAPIStrings.pokemon(id: 6) == "Charizard")
        #expect(PokeAPIStrings.pokemon(id: 9) == "Blastoise")
        #expect(PokeAPIStrings.pokemon(id: 3) == "Venusaur")
        #expect(PokeAPIStrings.pokemon(id: 1) == "Bulbasaur")
    }
    
    @Test("Ability localization")
    func testAbilityLocalization() {
        #expect(PokeAPIStrings.ability(id: 9) == "Static")
        #expect(PokeAPIStrings.ability(id: 66) == "Blaze")
        #expect(PokeAPIStrings.ability(id: 65) == "Overgrow")
        #expect(PokeAPIStrings.ability(id: 67) == "Torrent")
        #expect(PokeAPIStrings.ability(id: 26) == "Levitate")
    }
    
    @Test("Move localization")
    func testMoveLocalization() {
        #expect(PokeAPIStrings.move(id: 33) == "Tackle")
        #expect(PokeAPIStrings.move(id: 84) == "Thunder Shock")
        #expect(PokeAPIStrings.move(id: 53) == "Flamethrower")
        #expect(PokeAPIStrings.move(id: 55) == "Water Gun")
        #expect(PokeAPIStrings.move(id: 94) == "Psychic")
    }
    
    @Test("Type localization")
    func testTypeLocalization() {
        #expect(PokeAPIStrings.type(id: 1) == "Normal")
        #expect(PokeAPIStrings.type(id: 10) == "Fire")
        #expect(PokeAPIStrings.type(id: 11) == "Water")
        #expect(PokeAPIStrings.type(id: 13) == "Electric")
        #expect(PokeAPIStrings.type(id: 12) == "Grass")
        #expect(PokeAPIStrings.type(id: 14) == "Psychic")
    }
    
    @Test("Item localization")
    func testItemLocalization() {
        #expect(PokeAPIStrings.item(id: 4) == "Poké Ball")
        #expect(PokeAPIStrings.item(id: 1) == "Master Ball")
        #expect(PokeAPIStrings.item(id: 50) == "Rare Candy")
        #expect(PokeAPIStrings.item(id: 17) == "Potion")
        #expect(PokeAPIStrings.item(id: 3) == "Great Ball")
    }
    
    @Test("Location localization")
    func testLocationLocalization() {
        #expect(PokeAPIStrings.location(id: 1) == "Canalave City")
        #expect(PokeAPIStrings.location(id: 2) == "Eterna City")
        #expect(PokeAPIStrings.location(id: 10) == "Mt. Coronet")
    }
    
    @Test("Region localization")
    func testRegionLocalization() {
        #expect(PokeAPIStrings.region(id: 1) == "Kanto")
        #expect(PokeAPIStrings.region(id: 2) == "Johto")
        #expect(PokeAPIStrings.region(id: 3) == "Hoenn")
        #expect(PokeAPIStrings.region(id: 4) == "Sinnoh")
    }
    
    @Test("Stat localization")
    func testStatLocalization() {
        #expect(PokeAPIStrings.stat(id: 1) == "HP")
        #expect(PokeAPIStrings.stat(id: 2) == "Attack")
        #expect(PokeAPIStrings.stat(id: 3) == "Defense")
        #expect(PokeAPIStrings.stat(id: 4) == "Special Attack")
        #expect(PokeAPIStrings.stat(id: 5) == "Special Defense")
        #expect(PokeAPIStrings.stat(id: 6) == "Speed")
    }
    
    @Test("Nature localization")
    func testNatureLocalization() {
        #expect(PokeAPIStrings.nature(id: 1) == "Hardy")
        #expect(PokeAPIStrings.nature(id: 2) == "Bold")
        #expect(PokeAPIStrings.nature(id: 3) == "Modest")
        #expect(PokeAPIStrings.nature(id: 4) == "Calm")
        #expect(PokeAPIStrings.nature(id: 11) == "Adamant")
    }
    
    @Test("Generation localization")
    func testGenerationLocalization() {
        #expect(PokeAPIStrings.generation(id: 1) == "Generation I")
        #expect(PokeAPIStrings.generation(id: 2) == "Generation II")
        #expect(PokeAPIStrings.generation(id: 3) == "Generation III")
        #expect(PokeAPIStrings.generation(id: 4) == "Generation IV")
    }
    
    @Test("Color localization")
    func testColorLocalization() {
        #expect(PokeAPIStrings.color(id: 1) == "Black")
        #expect(PokeAPIStrings.color(id: 2) == "Blue")
        #expect(PokeAPIStrings.color(id: 3) == "Brown")
        #expect(PokeAPIStrings.color(id: 5) == "Green")
        #expect(PokeAPIStrings.color(id: 6) == "Pink")
    }
    
    @Test("Habitat localization")
    func testHabitatLocalization() {
        #expect(PokeAPIStrings.habitat(id: 1) == "cave")
        #expect(PokeAPIStrings.habitat(id: 2) == "forest")
        #expect(PokeAPIStrings.habitat(id: 3) == "grassland")
        #expect(PokeAPIStrings.habitat(id: 7) == "sea")
        #expect(PokeAPIStrings.habitat(id: 9) == "water's edge")
    }
}
