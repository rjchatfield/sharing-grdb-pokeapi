import StructuredQueries
import Tagged

/// Effects that occur when items are used with the move Fling.
/// Fling hurls the held item at the opponent, and different items
/// have different secondary effects beyond the base damage.
@Table("item_fling_effects")
public struct PokeAPIItemFlingEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique fling effect identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable effect name (e.g., "badly-poison", "burn", "paralyze")
    /// Describes what happens to the target when hit by the flung item
    @Column("identifier") public var identifier: Identifier

}