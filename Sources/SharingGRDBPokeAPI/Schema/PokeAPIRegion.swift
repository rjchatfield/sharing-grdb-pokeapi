import SharingGRDB

/// Game regions.
@Table("regions")
public struct PokeAPIRegion: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
}