import SharingGRDB

/// Individual game versions.
@Table("versions")
public struct PokeAPIVersion: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("version_group_id") public var versionGroupId: Int
    @Column("identifier") public var identifier: String
}