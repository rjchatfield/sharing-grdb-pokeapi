import StructuredQueries

/// Each Pokemon can have 1-2 types (e.g., Charizard is Fire/Flying).
/// The slot determines whether it's the primary (1) or secondary (2) type,
/// which affects move learning and some game mechanics.
@Table("pokemon_types")
public struct PokeAPIPokemonType: Codable, Equatable, Sendable {
    /// Foreign key to the pokemon table
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID
    
    /// Foreign key to the types table (Fire, Water, Electric, etc.)
    @Column("type_id") public var typeId: PokeAPIType.ID
    
    /// Type slot: 1 for primary type, 2 for secondary type
    /// Single-type Pokemon only have slot 1
    @Column("slot") public var slot: Int?
}
