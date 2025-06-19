import SharingGRDB

/// Pokemon game generations.
@Table("generations")
public struct PokeAPIGeneration: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("main_region_id") public var mainRegionId: Int
    @Column("identifier") public var identifier: String
}