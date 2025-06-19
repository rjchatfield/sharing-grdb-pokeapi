import SharingGRDB

/// Location definitions.
@Table("locations")
public struct PokeAPILocation: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("region_id") public var regionId: Int
    @Column("identifier") public var identifier: String
}