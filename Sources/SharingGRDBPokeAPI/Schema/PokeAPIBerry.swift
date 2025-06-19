import SharingGRDB

/// Berry-specific item data.
@Table("berries")
public struct PokeAPIBerry: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("item_id") public var itemId: Int
    @Column("firmness_id") public var firmnessId: Int
    @Column("natural_gift_power") public var naturalGiftPower: Int
    @Column("natural_gift_type_id") public var naturalGiftTypeId: Int
    @Column("size") public var size: Int
    @Column("max_harvest") public var maxHarvest: Int
    @Column("growth_time") public var growthTime: Int
    @Column("soil_dryness") public var soilDryness: Int
    @Column("smoothness") public var smoothness: Int
}