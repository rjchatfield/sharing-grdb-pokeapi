import StructuredQueries
import Tagged

/// Categories for organizing items in the player's bag inventory.
/// Items are grouped into pockets like Items, Poke Balls, TMs, Berries, Key Items,
/// and Mail for better organization and easier access during gameplay.
@Table("item_pockets")
public struct PokeAPIItemPocket: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this item pocket category
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable pocket name ("items", "poke-balls", "tms-hms", "berries", etc.)
    /// Used to categorize items for bag organization
    @Column("identifier") public var identifier: Identifier

}