import SharingGRDB

/// Represents all items in Pokemon games including healing items, Poke Balls,
/// evolution stones, held items, TMs, berries, and key items.
/// Items can be used in battle, held by Pokemon, or used in the overworld.
@Table("items")
public struct PokeAPIItem: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    
    /// Unique item identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable item name (e.g., "potion", "poke-ball", "fire-stone")
    @Column("identifier") public var identifier: String
    
    /// Item category (healing, pokeballs, evolution, held items, etc.)
    @Column("category_id") public var categoryId: PokeAPIItemCategory.ID

    /// Purchase cost in Poke Dollars (0 for items that can't be bought)
    @Column("cost") public var cost: Int
    
    /// Base power when used with the move Fling (Gen IV+)
    /// Nil for items that can't be flung
    @Column("fling_power") public var flingPower: Int?
    
    /// Special effect when used with the move Fling
    /// Nil for items with no special fling effect
    @Column("fling_effect_id") public var flingEffectId: Int?
}
