import StructuredQueries
import Tagged

/// Represents move flags that describe various attributes and behaviors of moves.
/// Move flags indicate special properties like whether a move makes contact, requires charging,
/// can be reflected, blocked by Protect, etc.
@Table("move_flags")
public struct PokeAPIMoveFlag: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for the move flag
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable identifier for the move flag (e.g., "contact", "charge", "protect")
    @Column("identifier") public var identifier: Identifier

}