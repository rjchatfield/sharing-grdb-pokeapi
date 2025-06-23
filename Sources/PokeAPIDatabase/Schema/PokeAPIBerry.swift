import StructuredQueries
import Tagged

/// Berries are special items that can be grown, fed to Pokemon, or used in crafting.
/// They have unique properties for Pokemon contests, cooking, and the Natural Gift move.
/// Berries can be planted and grown in berry gardens throughout various games.
@Table("berries")
public struct PokeAPIBerry: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// Unique berry identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Corresponding item ID in the items table
    @Column("item_id") public var itemId: PokeAPIItem.ID
    
    /// Firmness category (very soft, soft, hard, very hard, super hard)
    /// Affects how the berry is processed in Pokemon contests
    @Column("firmness_id") public var firmnessId: Int
    
    /// Base power when used with the move Natural Gift
    /// Range: 60-80
    @Column("natural_gift_power") public var naturalGiftPower: Int
    
    /// Type the move Natural Gift becomes when using this berry
    @Column("natural_gift_type_id") public var naturalGiftTypeId: Int
    
    /// Physical size of the berry in millimeters
    /// Range: 20-300
    @Column("size") public var size: Int
    
    /// Maximum number of berries that can be harvested from one plant
    /// Range: 5-15
    @Column("max_harvest") public var maxHarvest: Int
    
    /// Time in hours required for the berry to fully grow
    /// Range: 2-24
    @Column("growth_time") public var growthTime: Int
    
    /// How much this berry dries out the soil when planted
    /// Range: 4-35
    @Column("soil_dryness") public var soilDryness: Int
    
    /// Smoothness value used in Pokemon contest Pokeblock/Poffin creation
    /// Range: 20-60
    @Column("smoothness") public var smoothness: Int
}
