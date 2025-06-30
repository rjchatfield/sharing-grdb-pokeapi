import StructuredQueries
import Tagged

// TODO: Add description for item_flag_map table
@Table("item_flag_map")
public struct PokeAPIItemFlagMap: Decodable, Hashable, Sendable {

    // TODO: Add description for item_id
    @Column("item_id") public var itemId: PokeAPIItem.ID

    // TODO: Add description for item_flag_id
    @Column("item_flag_id") public var itemFlagId: PokeAPIItemFlag.ID

}