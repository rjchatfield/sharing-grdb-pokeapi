import SharingGRDB

/// Move target types (single target, all opponents, etc.).
@Table("move_targets")
public struct PokeAPIMoveTarget: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
}