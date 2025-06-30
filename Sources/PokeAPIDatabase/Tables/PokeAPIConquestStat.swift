import StructuredQueries
import Tagged

/// Statistical categories used in Pokemon Conquest battles.
/// Defines the various performance metrics for warriors and Pokemon
/// including attack, defense, accuracy, and special tactical abilities.
@Table("conquest_stats")
public struct PokeAPIConquestStat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Conquest statistic
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable stat name ("attack", "defense", "accuracy", etc.)
    /// Used for battle calculations and strategic planning
    @Column("identifier") public var identifier: Identifier

    /// Whether this is a base statistic that all units possess
    /// Base stats are fundamental to all warriors and Pokemon
    @Column("is_base") public var isBase: Bool

}