import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithStatsTests {
    @Test
    func testFetchAll() throws {
        let allPokemonWithStats = try PokeAPIPokemon.WithStats.fetchAll(.pokeAPI, limit: 2)
        assertInlineSnapshot(of: allPokemonWithStats, as: .customDump) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              ),
              [1]: (
                "Ivysaur",
                stats: [
                  [0]: HP: 60,
                  [1]: Attack: 62,
                  [2]: Defense: 63,
                  [3]: Special Attack: 80,
                  [4]: Special Defense: 80,
                  [5]: Speed: 60
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchAllForVersion() throws {
        // TODO: Generation 1 didn't have "Special" stats
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchAllForVersion(.pokeAPI, generationId: 1, limit: 1),
            as: .customDump
        ) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              )
            ]
            """
        }
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchAllForVersion(.pokeAPI, generationId: 6, limit: 1),
            as: .customDump
        ) {
            """
            [
              [0]: (
                "Bulbasaur",
                stats: [
                  [0]: HP: 45,
                  [1]: Attack: 49,
                  [2]: Defense: 49,
                  [3]: Special Attack: 65,
                  [4]: Special Defense: 65,
                  [5]: Speed: 45
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        // TODO: Should handle generationId. Because Generation 1 didn't have "Special" stats
        assertInlineSnapshot(
            of: try PokeAPIPokemon.WithStats.fetchOne(.pokeAPI, pokemonId: 1),
            as: .customDump
        ) {
            """
            (
              "Bulbasaur",
              stats: [
                [0]: HP: 45,
                [1]: Attack: 49,
                [2]: Defense: 49,
                [3]: Special Attack: 65,
                [4]: Special Defense: 65,
                [5]: Speed: 45
              ]
            )
            """
        }
    }
}

// MARK: -

extension PokeAPIPokemon.WithStats: CustomDumpRepresentable {
    public var customDumpValue: Any {
        (
            pokemon.localizedName,
            stats: stats
        )
    }
}

extension PokeAPIPokemon.WithStats.StatData: CustomDumpStringConvertible {
    public var customDumpDescription: String {
        "\(stat.localizedName): \(baseStat)"
    }
}
