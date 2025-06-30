import StructuredQueries
import Tagged

/// Flags that describe properties and behaviors of items.
/// Items can have multiple flags indicating characteristics like
/// whether they're consumable, countable, or have special properties.
@Table("item_flags")
public struct PokeAPIItemFlag: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique item flag identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable flag name (e.g., "countable", "consumable", "holdable")
    /// Describes a specific property or behavior of items
    @Column("identifier") public var identifier: Identifier

}