import SharingGRDB

/// Item definitions.
@Table("items")
public struct PokeAPIItem: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("category_id") public var categoryId: Int
    @Column("cost") public var cost: Int
    @Column("fling_power") public var flingPower: Int?
    @Column("fling_effect_id") public var flingEffectId: Int?
}