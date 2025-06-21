import StructuredQueries

/// Natures affect Pokemon stats and berry preferences (introduced in Gen III).
/// Each nature increases one stat by 10% and decreases another by 10%,
/// or has no effect (neutral natures). There are 25 total natures.
@Table("natures")
public struct PokeAPINature: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique nature identifier (1-25)
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable nature name (e.g., "adamant", "modest", "jolly")
    @Column("identifier") public var identifier: String
    
    /// Stat that this nature decreases by 10%
    /// Same as increased_stat_id for neutral natures
    @Column("decreased_stat_id") public var decreasedStatId: PokeAPIStat.ID

    /// Stat that this nature increases by 10%
    /// Same as decreased_stat_id for neutral natures
    @Column("increased_stat_id") public var increasedStatId: PokeAPIStat.ID
    
    /// Berry flavor this nature dislikes (affects Pokeblocks/Poffins)
    @Column("hates_flavor_id") public var hatesFlavorId: Int
    
    /// Berry flavor this nature likes (affects Pokeblocks/Poffins)
    @Column("likes_flavor_id") public var likesFlavorId: Int
    
    /// In-game index for this nature
    @Column("game_index") public var gameIndex: Int
}
