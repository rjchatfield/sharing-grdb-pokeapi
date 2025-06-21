import StructuredQueries

/// Organizes items into logical categories within the player's bag pockets.
/// Categories help group similar items together for easier navigation and organization,
/// such as healing items, Poke Balls, berries, TMs, and key items.
@Table("item_categories")
public struct PokeAPIItemCategory: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    public typealias Identifier = String

    /// Unique item category identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable category name (e.g., "healing", "pokeballs", "evolution", "held-items")
    /// Examples: stat-boosts, medicine, standard-balls, special-balls, type-protection
    @Column("identifier") public var identifier: Identifier

    /// Bag pocket this category belongs to (Items, Medicine, Poke Balls, TMs, Berries, Key Items)
    /// Determines which bag compartment the items appear in
    @Column("pocket_id") public var pocketId: Int

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
