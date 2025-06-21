import StructuredQueries

/// Groups related Pokemon game versions that share core mechanics and data.
/// Version groups typically include paired versions (Red/Blue) or sets of games
/// released together with similar features but different exclusive content.
@Table("version_groups")
public struct PokeAPIVersionGroup: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    
    /// Unique version group identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable version group name (e.g., "red-blue", "gold-silver", "diamond-pearl")
    /// Represents collections of related game versions
    @Column("identifier") public var identifier: String
    
    /// Generation this version group belongs to
    /// Links the games to their respective generation's Pokemon and mechanics
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID
    
    /// Release order within the generation
    /// Used for chronological sorting of version groups
    @Column("order") public var order: Int
}
