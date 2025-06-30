import StructuredQueries
import Tagged

/// Movement displacement effects that some moves can cause in Pokemon Conquest battles.
/// These effects move Pokemon to different positions on the tactical grid,
/// adding a strategic element of battlefield control and positioning.
@Table("conquest_move_displacements")
public struct PokeAPIConquestMoveDisplacement: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this displacement effect
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable displacement type name (e.g., "push", "pull", "switch")
    /// Describes how the displacement moves Pokemon on the battlefield
    @Column("identifier") public var identifier: Identifier

    /// Whether this displacement affects the target (1) or user (0)
    /// Determines which Pokemon gets moved by the displacement effect
    @Column("affects_target") public var affectsTarget: Int

}