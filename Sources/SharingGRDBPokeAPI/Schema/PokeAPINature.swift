import SharingGRDB

/// Pokemon nature definitions.
@Table("natures")
public struct PokeAPINature: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("decreased_stat_id") public var decreasedStatId: Int
    @Column("increased_stat_id") public var increasedStatId: Int
    @Column("hates_flavor_id") public var hatesFlavorId: Int
    @Column("likes_flavor_id") public var likesFlavorId: Int
    @Column("game_index") public var gameIndex: Int
}