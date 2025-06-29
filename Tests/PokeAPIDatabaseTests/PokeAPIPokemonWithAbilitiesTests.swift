import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithAbilitiesTests {
    @Test
    func testFetchAll() throws {
        // TODO: Pass in PokeAPIGeneration.ID. I don't want "Solar Power" if I'm playing gen 3
        let allPokemonWithAbilities = try PokeAPIPokemon.WithAbilities.fetchAll(.pokeAPI, limit: 4)
        assertInlineSnapshot(of: allPokemonWithAbilities, as: .customDump) {
            """
            [
              [0]: (
                "Bulbasaur",
                abilities: [
                  [0]: Overgrow { slot:1, hidden:false, gen:3 },
                  [1]: Chlorophyll { slot:3, hidden:true, gen:3 }
                ]
              ),
              [1]: (
                "Ivysaur",
                abilities: [
                  [0]: Overgrow { slot:1, hidden:false, gen:3 },
                  [1]: Chlorophyll { slot:3, hidden:true, gen:3 }
                ]
              ),
              [2]: (
                "Venusaur",
                abilities: [
                  [0]: Overgrow { slot:1, hidden:false, gen:3 },
                  [1]: Chlorophyll { slot:3, hidden:true, gen:3 }
                ]
              ),
              [3]: (
                "Charmander",
                abilities: [
                  [0]: Blaze { slot:1, hidden:false, gen:3 },
                  [1]: Solar Power { slot:3, hidden:true, gen:4 }
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        // TODO: Pass in PokeAPIGeneration.ID. I don't want "Solar Power" if I'm playing gen 3
        let pokemonWithAbilities = try PokeAPIPokemon.WithAbilities.fetchOne(.pokeAPI, pokemonId: 4)
        assertInlineSnapshot(of: pokemonWithAbilities, as: .customDump) {
            """
            (
              "Charmander",
              abilities: [
                [0]: Blaze { slot:1, hidden:false, gen:3 },
                [1]: Solar Power { slot:3, hidden:true, gen:4 }
              ]
            )
            """
        }
    }
}

// MARK: -

extension PokeAPIPokemon.WithAbilities: CustomDumpRepresentable {
    public var customDumpValue: Any {
        (
            pokemon.localizedName,
            abilities: abilities
        )
    }
}

extension PokeAPIPokemon.WithAbilities.AbilityData: CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(ability.localizedName) { slot:\(slot), hidden:\(isHidden), gen:\(ability.generationId) }"
    }
}
