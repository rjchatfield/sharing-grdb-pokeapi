import StructuredQueries

/// Links Pokemon to their stat values (HP, Attack, Defense, etc.).
/// Each Pokemon has 6 main stats, so each Pokemon will have 6 records in this table.
/// Also tracks EV (Effort Value) yield when the Pokemon is defeated.
@Table("pokemon_stats")
public struct PokeAPIPokemonStat: Decodable, Equatable, Sendable {
    /// Foreign key to the pokemon table
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID
    
    /// Foreign key to the stats table (HP, Attack, Defense, Sp. Attack, Sp. Defense, Speed)
    @Column("stat_id") public var statId: PokeAPIStat.ID
    
    /// Base stat value for this Pokemon (typically 1-255)
    /// This is the Pokemon's inherent stat value at level 50 with neutral nature
    /// Range: 1-255
    @Column("base_stat") public var baseStat: Int
    
    /// Effort Value (EV) yield when this Pokemon is defeated (0-3)
    /// Determines how many EVs the victor gains in this stat
    /// Example: Defeating Machamp gives 3 Attack EVs
    /// Range: 0-3
    @Column("effort") public var effort: Int
}
