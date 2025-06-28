import CustomDump
import InlineSnapshotTesting
import PokeAPIDatabase
import Tagged
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIPokemonWithMovesTests {
    @Test
    func testFetchAll() throws {
        let allPokemonWithMoves = try PokeAPIPokemon.WithMoves.fetchAll(.pokeAPI, versionGroupId: 1, limit: 2)
        assertInlineSnapshot(of: allPokemonWithMoves, as: .customDump) {
            """
            [
              [0]: (
                "Bulbasaur",
                moves: [
                  [0]: 'Tackle' at level '1',
                  [1]: 'Growl' at level '1',
                  [2]: 'Leech Seed' at level '7',
                  [3]: 'Vine Whip' at level '13',
                  [4]: 'Poison Powder' at level '20',
                  [5]: 'Razor Leaf' at level '27',
                  [6]: 'Growth' at level '34',
                  [7]: 'Sleep Powder' at level '41',
                  [8]: 'Solar Beam' at level '48',
                  [9]: 'Swords Dance',
                  [10]: 'Cut',
                  [11]: 'Body Slam',
                  [12]: 'Take Down',
                  [13]: 'Double-Edge',
                  [14]: 'Mega Drain',
                  [15]: 'Solar Beam',
                  [16]: 'Toxic',
                  [17]: 'Rage',
                  [18]: 'Mimic',
                  [19]: 'Double Team',
                  [20]: 'Reflect',
                  [21]: 'Bide',
                  [22]: 'Rest',
                  [23]: 'Substitute'
                ]
              ),
              [1]: (
                "Ivysaur",
                moves: [
                  [0]: 'Tackle' at level '1',
                  [1]: 'Growl' at level '1',
                  [2]: 'Leech Seed' at level '1',
                  [3]: 'Leech Seed' at level '7',
                  [4]: 'Vine Whip' at level '13',
                  [5]: 'Poison Powder' at level '22',
                  [6]: 'Razor Leaf' at level '30',
                  [7]: 'Growth' at level '38',
                  [8]: 'Sleep Powder' at level '46',
                  [9]: 'Solar Beam' at level '54',
                  [10]: 'Swords Dance',
                  [11]: 'Cut',
                  [12]: 'Body Slam',
                  [13]: 'Take Down',
                  [14]: 'Double-Edge',
                  [15]: 'Mega Drain',
                  [16]: 'Solar Beam',
                  [17]: 'Toxic',
                  [18]: 'Rage',
                  [19]: 'Mimic',
                  [20]: 'Double Team',
                  [21]: 'Reflect',
                  [22]: 'Bide',
                  [23]: 'Rest',
                  [24]: 'Substitute'
                ]
              )
            ]
            """
        }
    }

    @Test
    func testFetchOne() throws {
        try assertInlineSnapshot(
            of: PokeAPIPokemon.WithMoves.fetchOne(
                .pokeAPI,
                pokemonId: 82,
                versionGroupId: .redBlue
            ),
            as: .customDump
        ) {
            """
            (
              "Magneton",
              moves: [
                [0]: 'Tackle' at level '1',
                [1]: 'Sonic Boom' at level '1',
                [2]: 'Thunder Shock' at level '1',
                [3]: 'Sonic Boom' at level '21',
                [4]: 'Thunder Shock' at level '25',
                [5]: 'Supersonic' at level '29',
                [6]: 'Thunder Wave' at level '38',
                [7]: 'Swift' at level '46',
                [8]: 'Screech' at level '54',
                [9]: 'Take Down',
                [10]: 'Double-Edge',
                [11]: 'Hyper Beam',
                [12]: 'Thunderbolt',
                [13]: 'Thunder Wave',
                [14]: 'Thunder',
                [15]: 'Toxic',
                [16]: 'Rage',
                [17]: 'Teleport',
                [18]: 'Mimic',
                [19]: 'Double Team',
                [20]: 'Reflect',
                [21]: 'Bide',
                [22]: 'Swift',
                [23]: 'Flash',
                [24]: 'Rest',
                [25]: 'Substitute'
              ]
            )
            """
        }

        // Same pokemon in later generation
        try assertInlineSnapshot(
            of: PokeAPIPokemon.WithMoves.fetchOne(
                .pokeAPI,
                pokemonId: 82,
                versionGroupId: .sunMoon
            ),
            as: .customDump
        ) {
            """
            (
              "Magneton",
              moves: [
                [0]: 'Tri Attack' at level '1',
                [1]: 'Zap Cannon' at level '1',
                [2]: 'Electric Terrain' at level '1',
                [3]: 'Tackle' at level '1',
                [4]: 'Supersonic' at level '1',
                [5]: 'Thunder Shock' at level '1',
                [6]: 'Magnet Bomb' at level '1',
                [7]: 'Thunder Shock' at level '5',
                [8]: 'Magnet Bomb' at level '7',
                [9]: 'Thunder Wave' at level '11',
                [10]: 'Light Screen' at level '13',
                [11]: 'Sonic Boom' at level '17',
                [12]: 'Spark' at level '19',
                [13]: 'Mirror Shot' at level '23',
                [14]: 'Metal Sound' at level '25',
                [15]: 'Electro Ball' at level '29',
                [16]: 'Flash Cannon' at level '33',
                [17]: 'Screech' at level '39',
                [18]: 'Discharge' at level '43',
                [19]: 'Lock-On' at level '49',
                [20]: 'Magnet Rise' at level '53',
                [21]: 'Gyro Ball' at level '59',
                [22]: 'Zap Cannon' at level '63',
                [23]: 'Hyper Beam',
                [24]: 'Thunderbolt',
                [25]: 'Thunder Wave',
                [26]: 'Thunder',
                [27]: 'Toxic',
                [28]: 'Double Team',
                [29]: 'Light Screen',
                [30]: 'Reflect',
                [31]: 'Explosion',
                [32]: 'Rest',
                [33]: 'Tri Attack',
                [34]: 'Substitute',
                [35]: 'Protect',
                [36]: 'Swagger',
                [37]: 'Sleep Talk',
                [38]: 'Return',
                [39]: 'Frustration',
                [40]: 'Hidden Power',
                [41]: 'Rain Dance',
                [42]: 'Sunny Day',
                [43]: 'Psych Up',
                [44]: 'Facade',
                [45]: 'Gyro Ball',
                [46]: 'Giga Impact',
                [47]: 'Flash Cannon',
                [48]: 'Charge Beam',
                [49]: 'Round',
                [50]: 'Volt Switch',
                [51]: 'Wild Charge',
                [52]: 'Confide'
              ]
            )
            """
        }
    }
}

// MARK: -

extension PokeAPIPokemon.WithMoves: @retroactive CustomDumpRepresentable {
    public var customDumpValue: Any {
        (
            pokemon.localizedName,
            moves: moves
        )
    }
}

extension PokeAPIPokemon.WithMoves.MoveData: @retroactive CustomDumpStringConvertible {
    public var customDumpDescription: String {
        var result = "'\(move.localizedName)'"
        if let level {
            result += " at level '\(level)'"
        }
        return result
    }
}
