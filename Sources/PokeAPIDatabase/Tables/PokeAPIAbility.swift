import StructuredQueries
import Tagged

/// Pokemon abilities provide passive effects during battle or in the overworld.
/// Each Pokemon can have multiple possible abilities, but only one active at a time.
/// Examples include Static (paralysis chance), Levitate (Ground immunity), etc.
@Table("abilities")
public struct PokeAPIAbility: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique ability identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable ability name (e.g., "static", "levitate", "water-absorb")
    @Column("identifier") public var identifier: Identifier
    
    /// Generation in which this ability was first introduced (3+)
    /// Abilities were introduced in Generation III (Ruby/Sapphire)
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID
    
    /// Whether this ability appears in main series games
    /// False for abilities exclusive to spin-offs or side games
    @Column("is_main_series") public var isMainSeries: Bool

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.ability(id: id, identifier: identifier)
    }
}
