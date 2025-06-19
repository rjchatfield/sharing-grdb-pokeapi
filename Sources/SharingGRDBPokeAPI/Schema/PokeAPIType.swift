import SharingGRDB

/// Pokemon type definitions.
@Table("types")
public struct PokeAPIType: Decodable, Equatable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("generation_id") public var generation_id: Int
    @Column("damage_class_id") public var damage_class_id: Int
}
