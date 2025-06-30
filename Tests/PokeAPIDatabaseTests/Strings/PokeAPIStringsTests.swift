import Testing
import PokeAPIDatabase

@Suite("PokeAPI Strings Localization Tests")
struct PokeAPIStringsTests {
    @Test("Pokemon localization")
    func testPokemonLocalization() {
        #expect(PokeAPIStrings.pokemon(id: 25, identifier: "ignored") == "Pikachu")
        #expect(PokeAPIStrings.pokemon(id: 6, identifier: "ignored") == "Charizard")
        #expect(PokeAPIStrings.pokemon(id: 9, identifier: "ignored") == "Blastoise")
        #expect(PokeAPIStrings.pokemon(id: 3, identifier: "ignored") == "Venusaur")
        #expect(PokeAPIStrings.pokemon(id: 1, identifier: "ignored") == "Bulbasaur")
        #expect(PokeAPIStrings.pokemon(id: 99999, identifier: "super-charazard") == "Super Charazard")
    }
    
    @Test("Ability localization")
    func testAbilityLocalization() {
        #expect(PokeAPIStrings.ability(id: 9, identifier: "ignored") == "Static")
        #expect(PokeAPIStrings.ability(id: 66, identifier: "ignored") == "Blaze")
        #expect(PokeAPIStrings.ability(id: 65, identifier: "ignored") == "Overgrow")
        #expect(PokeAPIStrings.ability(id: 67, identifier: "ignored") == "Torrent")
        #expect(PokeAPIStrings.ability(id: 26, identifier: "ignored") == "Levitate")
        #expect(PokeAPIStrings.ability(id: 99999, identifier: "super-static") == "Super Static")
    }
    
    @Test("Move localization")
    func testMoveLocalization() {
        #expect(PokeAPIStrings.move(id: 33, identifier: "ignored") == "Tackle")
        #expect(PokeAPIStrings.move(id: 84, identifier: "ignored") == "Thunder Shock")
        #expect(PokeAPIStrings.move(id: 53, identifier: "ignored") == "Flamethrower")
        #expect(PokeAPIStrings.move(id: 55, identifier: "ignored") == "Water Gun")
        #expect(PokeAPIStrings.move(id: 94, identifier: "ignored") == "Psychic")
        #expect(PokeAPIStrings.move(id: 99999, identifier: "super-tackle") == "Super Tackle")
    }
    
    @Test("Type localization")
    func testTypeLocalization() {
        #expect(PokeAPIStrings.type(id: 1, identifier: "ignored") == "Normal")
        #expect(PokeAPIStrings.type(id: 10, identifier: "ignored") == "Fire")
        #expect(PokeAPIStrings.type(id: 11, identifier: "ignored") == "Water")
        #expect(PokeAPIStrings.type(id: 13, identifier: "ignored") == "Electric")
        #expect(PokeAPIStrings.type(id: 12, identifier: "ignored") == "Grass")
        #expect(PokeAPIStrings.type(id: 14, identifier: "ignored") == "Psychic")
        #expect(PokeAPIStrings.type(id: 99999, identifier: "super-normal") == "Super Normal")
    }
    
    @Test("Item localization")
    func testItemLocalization() {
        #expect(PokeAPIStrings.item(id: 4, identifier: "ignored") == "Poké Ball")
        #expect(PokeAPIStrings.item(id: 1, identifier: "ignored") == "Master Ball")
        #expect(PokeAPIStrings.item(id: 50, identifier: "ignored") == "Rare Candy")
        #expect(PokeAPIStrings.item(id: 17, identifier: "ignored") == "Potion")
        #expect(PokeAPIStrings.item(id: 3, identifier: "ignored") == "Great Ball")
        #expect(PokeAPIStrings.item(id: 99999, identifier: "super-poke-ball") == "Super Poke Ball")
    }
    
    @Test("Location localization")
    func testLocationLocalization() {
        #expect(PokeAPIStrings.location(id: 1, identifier: "ignored") == "Canalave City")
        #expect(PokeAPIStrings.location(id: 2, identifier: "ignored") == "Eterna City")
        #expect(PokeAPIStrings.location(id: 10, identifier: "ignored") == "Mt. Coronet")
        #expect(PokeAPIStrings.location(id: 99999, identifier: "super-canalave-city") == "Super Canalave City")
    }
    
    @Test("Region localization")
    func testRegionLocalization() {
        #expect(PokeAPIStrings.region(id: 1, identifier: "ignored") == "Kanto")
        #expect(PokeAPIStrings.region(id: 2, identifier: "ignored") == "Johto")
        #expect(PokeAPIStrings.region(id: 3, identifier: "ignored") == "Hoenn")
        #expect(PokeAPIStrings.region(id: 4, identifier: "ignored") == "Sinnoh")
        #expect(PokeAPIStrings.region(id: 99999, identifier: "super-kanto") == "Super Kanto")
    }
    
    @Test("Stat localization")
    func testStatLocalization() {
        #expect(PokeAPIStrings.stat(id: .hp) == "HP")
        #expect(PokeAPIStrings.stat(id: .attack) == "Attack")
        #expect(PokeAPIStrings.stat(id: .defense) == "Defense")
        #expect(PokeAPIStrings.stat(id: .specialAttack) == "Special Attack")
        #expect(PokeAPIStrings.stat(id: .specialDefense) == "Special Defense")
        #expect(PokeAPIStrings.stat(id: .speed) == "Speed")
        #expect(PokeAPIStrings.stat(id: .accuracy) == "Accuracy")
        #expect(PokeAPIStrings.stat(id: .evasion) == "Evasion")
    }
    
    @Test("Nature localization")
    func testNatureLocalization() {
        #expect(PokeAPIStrings.nature(id: 1, identifier: "ignored") == "Hardy")
        #expect(PokeAPIStrings.nature(id: 2, identifier: "ignored") == "Bold")
        #expect(PokeAPIStrings.nature(id: 3, identifier: "ignored") == "Modest")
        #expect(PokeAPIStrings.nature(id: 4, identifier: "ignored") == "Calm")
        #expect(PokeAPIStrings.nature(id: 11, identifier: "ignored") == "Adamant")
        #expect(PokeAPIStrings.nature(id: 99999, identifier: "super-bold") == "Super Bold")
    }
    
    @Test("Generation localization")
    func testGenerationLocalization() {
        #expect(PokeAPIStrings.generation(id: 1, identifier: "ignored") == "Generation I")
        #expect(PokeAPIStrings.generation(id: 2, identifier: "ignored") == "Generation II")
        #expect(PokeAPIStrings.generation(id: 3, identifier: "ignored") == "Generation III")
        #expect(PokeAPIStrings.generation(id: 4, identifier: "ignored") == "Generation IV")
        #expect(PokeAPIStrings.generation(id: 99999, identifier: "super-generation-x") == "Super Generation X")
    }
    
    @Test("Color localization")
    func testColorLocalization() {
        #expect(PokeAPIStrings.color(id: 1) == "Black")
        #expect(PokeAPIStrings.color(id: 2) == "Blue")
        #expect(PokeAPIStrings.color(id: 3) == "Brown")
        #expect(PokeAPIStrings.color(id: 5) == "Green")
        #expect(PokeAPIStrings.color(id: 6) == "Pink")
        #expect(PokeAPIStrings.color(id: 99999) == nil)
    }
    
    @Test("Habitat localization")
    func testHabitatLocalization() {
        #expect(PokeAPIStrings.habitat(id: 1) == "cave")
        #expect(PokeAPIStrings.habitat(id: 2) == "forest")
        #expect(PokeAPIStrings.habitat(id: 3) == "grassland")
        #expect(PokeAPIStrings.habitat(id: 7) == "sea")
        #expect(PokeAPIStrings.habitat(id: 9) == "water's edge")
        #expect(PokeAPIStrings.habitat(id: 99999) == nil)
    }
}
