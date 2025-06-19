import SharingGRDB

/// Move damage class types (Physical, Special, Status).
@Table("move_damage_classes")
public struct PokeAPIMoveDamageClass: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
}