import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithEvolutionsTests {
    @Test
    func testFetchAll() throws {
        let allPokemonWithEvolutions = try PokeAPIPokemon.WithEvolutions.fetchAll(.pokeAPI, limit: 3)
        assertInlineSnapshot(of: allPokemonWithEvolutions, as: .customDump) {
            """
            [
              [0]: Bulbasaur evolved in 0 ways,
              [1]: Ivysaur evolved in 1 ways,
              [2]: Venusaur evolved in 1 ways
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        let pokemonWithEvolutions = try PokeAPIPokemon.WithEvolutions.fetchOne(.pokeAPI, pokemonId: 20)
        assertInlineSnapshot(of: pokemonWithEvolutions, as: .customDump) {
            """
            Raticate evolved in 2 ways
            """
        }
    }
}

// MARK: -

extension PokeAPIPokemon.WithEvolutions: CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(pokemon.localizedName) evolved in \(evolutions.count) ways"
    }
}
