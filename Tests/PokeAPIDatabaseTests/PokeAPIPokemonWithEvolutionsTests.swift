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

    @Test("Test that evolution chains properly filter forms by version")
    func testEvolutionChainFormFiltering() throws {
        let gen1VersionId = PokeAPIVersion.ID.red
        let gen8VersionId = PokeAPIVersion.ID.sword

        // Get Charizard evolution chain in Gen 1 vs Gen 8
        let charizardGen1Chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
            pokemonId: PokeAPIPokemon.ID(rawValue: 6), // Charizard ID
            versionId: gen1VersionId
        )

        let charizardGen8Chain = try PokeAPIPokemon.WithEvolutionChain.fetchChainForPokemon(
            .pokeAPI,
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
}

// MARK: -

extension PokeAPIPokemon.WithEvolutions: @retroactive CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(pokemon.localizedName) evolved in \(evolutions.count) ways"
    }
}
