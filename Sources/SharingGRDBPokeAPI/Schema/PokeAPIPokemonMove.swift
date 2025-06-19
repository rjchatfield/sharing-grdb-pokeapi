import SharingGRDB

/// Defines which moves each Pokemon can learn and how they learn them.
/// Different game versions may have different move learning patterns.
/// Moves can be learned by leveling up, TMs/TRs, tutors, breeding, or evolution.
@Table("pokemon_moves")
public struct PokeAPIPokemonMove: Decodable, Hashable, Sendable {
    /// Foreign key to the pokemon table
    @Column("pokemon_id") public var pokemonId: Int
    
    /// Game version group this move learning data applies to
    /// Move availability and learning methods can vary between game versions
    @Column("version_group_id") public var versionGroupId: Int
    
    /// Foreign key to the moves table - the move being learned
    @Column("move_id") public var moveId: Int
    
    /// Learning method (level-up, TM, tutor, egg, etc.)
    /// Determines how the Pokemon acquires this move
    @Column("pokemon_move_method_id") public var pokemonMoveMethodId: Int
    
    /// Level at which the move is learned (for level-up moves)
    /// 0 for moves learned at evolution, 1 for starting moves, -1 for non-level moves
    @Column("level") public var level: Int
    
    /// Order in which moves are learned at the same level
    /// Used for sorting when multiple moves are learned simultaneously
    @Column("order") public var order: Int?
    
    /// Mastery level or special conditions (used in some games)
    /// May indicate proficiency requirements or special learning conditions
    @Column("mastery") public var mastery: String?
}
