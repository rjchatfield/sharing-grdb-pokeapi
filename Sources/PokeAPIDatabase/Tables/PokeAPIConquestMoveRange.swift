import StructuredQueries
import Tagged

/// Tactical range patterns for moves in Pokemon Conquest's grid-based battles.
/// Each move has a specific range pattern that determines which battlefield positions it can target.
/// Range patterns are crucial for strategic positioning and tactical combat planning.
@Table("conquest_move_ranges")
public struct PokeAPIConquestMoveRange: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this range pattern
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable range pattern name (e.g., "close", "far", "sweep")
    /// Describes the shape or type of the targeting pattern
    @Column("identifier") public var identifier: Identifier

    /// Maximum number of targets this range pattern can affect
    /// Determines how many Pokemon can be hit by a single move use
    @Column("targets") public var targets: Int

}