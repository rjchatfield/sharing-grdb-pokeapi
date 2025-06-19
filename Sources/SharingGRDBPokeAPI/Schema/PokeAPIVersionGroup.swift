import SharingGRDB

/// Groups of game versions.
@Table("version_groups")
public struct PokeAPIVersionGroup: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("generation_id") public var generationId: Int
    @Column("order") public var order: Int
}