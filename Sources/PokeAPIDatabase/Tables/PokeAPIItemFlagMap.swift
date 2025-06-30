import StructuredQueries
import Tagged

/// Junction table mapping items to their associated flags.
/// Since items can have multiple flags and flags can apply to multiple items,
/// this many-to-many relationship table connects them.
@Table("item_flag_map")
public struct PokeAPIItemFlagMap: Decodable, Hashable, Sendable {

    /// Reference to the item that has this flag
    /// Links to the items table
    @Column("item_id") public var itemId: PokeAPIItem.ID

    /// Reference to the flag that applies to this item
    /// Links to the item_flags table
    @Column("item_flag_id") public var itemFlagId: PokeAPIItemFlag.ID

}