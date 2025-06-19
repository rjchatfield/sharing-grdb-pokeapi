import SharingGRDB

/// Base stats for each Pokemon.
@Table("pokemon_stats")
public struct PokeAPIPokemonStat: Decodable, Equatable, Sendable {
    @Column("pokemon_id") public var pokemonId: Int
    @Column("stat_id") public var statId: Int
    @Column("base_stat") public var baseStat: Int
    @Column("effort") public var effort: Int
}
