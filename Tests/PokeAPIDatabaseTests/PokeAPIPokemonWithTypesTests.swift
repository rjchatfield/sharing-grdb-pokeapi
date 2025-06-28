import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithTypesTests {
    @Test
    func testFetchAll() throws {
        // TODO: Pass in generation or version. Gen 6 added Fairy type to Jigglypuff
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithTypes.fetchAll(.pokeAPI, limit: 50),
            as: .customDump
        ) {
            """
            [
              [0]: Bulbasaur: Grass/Poison,
              [1]: Ivysaur: Grass/Poison,
              [2]: Venusaur: Grass/Poison,
              [3]: Charmander: Fire,
              [4]: Charmeleon: Fire,
              [5]: Charizard: Fire/Flying,
              [6]: Squirtle: Water,
              [7]: Wartortle: Water,
              [8]: Blastoise: Water,
              [9]: Caterpie: Bug,
              [10]: Metapod: Bug,
              [11]: Butterfree: Bug/Flying,
              [12]: Weedle: Bug/Poison,
              [13]: Kakuna: Bug/Poison,
              [14]: Beedrill: Bug/Poison,
              [15]: Pidgey: Normal/Flying,
              [16]: Pidgeotto: Normal/Flying,
              [17]: Pidgeot: Normal/Flying,
              [18]: Rattata: Normal,
              [19]: Raticate: Normal,
              [20]: Spearow: Normal/Flying,
              [21]: Fearow: Normal/Flying,
              [22]: Ekans: Poison,
              [23]: Arbok: Poison,
              [24]: Pikachu: Electric,
              [25]: Raichu: Electric,
              [26]: Sandshrew: Ground,
              [27]: Sandslash: Ground,
              [28]: Nidoran♀: Poison,
              [29]: Nidorina: Poison,
              [30]: Nidoqueen: Poison/Ground,
              [31]: Nidoran♂: Poison,
              [32]: Nidorino: Poison,
              [33]: Nidoking: Poison/Ground,
              [34]: Clefairy: Fairy,
              [35]: Clefable: Fairy,
              [36]: Vulpix: Fire,
              [37]: Ninetales: Fire,
              [38]: Jigglypuff: Normal/Fairy (Multi-Generation: [1, 6]),
              [39]: Wigglytuff: Normal/Fairy (Multi-Generation: [1, 6]),
              [40]: Zubat: Poison/Flying,
              [41]: Golbat: Poison/Flying,
              [42]: Oddish: Grass/Poison,
              [43]: Gloom: Grass/Poison,
              [44]: Vileplume: Grass/Poison,
              [45]: Paras: Bug/Grass,
              [46]: Parasect: Bug/Grass,
              [47]: Venonat: Bug/Poison,
              [48]: Venomoth: Bug/Poison,
              [49]: Diglett: Ground
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        // TODO: Pass in generation or version. Gen 6 added Fairy type to Jigglypuff
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithTypes.fetchOne(.pokeAPI, pokemonId: 39),
            as: .customDump
        ) {
            """
            Jigglypuff: Normal/Fairy (Multi-Generation: [1, 6])
            """
        }
    }

    // MARK: - Type Changes Across Generations

//    @Test func testGengarTypingConsistency() throws {
//        // Gengar has always been Ghost/Poison, but lost Levitate ability in Gen 7
//        // (Note: Abilities aren't the same as types, but this tests type consistency)
//        let database = Helper.sqlDB()
//
//        let gengarTypes = try PokeAPIPokemon.WithTypes.fetchOne(
//            database,
//            pokemonId: PokeAPIPokemon.ID(94) // Gengar
//        )
//
//        // Gengar should have exactly 2 types
//        #expect(gengarTypes.types.count == 2, "Gengar should have exactly 2 types")
//
//        let typeNames = gengarTypes.types.map { $0.type.identifier }.sorted()
//        #expect(typeNames == ["ghost", "poison"], "Gengar should be Ghost/Poison type")
//
//        // Verify type slots (primary vs secondary)
//        let ghostType = gengarTypes.types.first { $0.type.identifier == "ghost" }
//        let poisonType = gengarTypes.types.first { $0.type.identifier == "poison" }
//
//        #expect(ghostType?.slot == 1, "Ghost should be Gengar's primary type")
//        #expect(poisonType?.slot == 2, "Poison should be Gengar's secondary type")
//    }
}

// MARK: -

extension PokeAPIPokemon.WithTypes: @retroactive CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(pokemon.localizedName): \(types.map(\.localizedName).joined(separator: "/"))\(isMultiGeneration ? " (Multi-Generation: \(types.map(\.generationId)))" : "")"
    }

    private var isMultiGeneration: Bool {
        Set(types.map(\.generationId)).count > 1
    }
}
