import StructuredQueries

/// Defines the different ways wild Pokemon can be encountered in the game world.
/// Each method represents a specific interaction type that can trigger a wild battle,
/// such as walking in tall grass, surfing on water, or fishing with different rods.
@Table("encounter_methods")
public struct PokeAPIEncounterMethod: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique encounter method identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable method name (e.g., "walk", "surf", "old-rod", "good-rod", "super-rod")
    /// Examples: walking in grass, surfing on water, fishing, rock smash, headbutt trees
    @Column("identifier") public var identifier: String
    
    /// Display order for UI listing purposes
    /// Lower numbers appear first in encounter method lists
    @Column("order") public var order: Int
}
