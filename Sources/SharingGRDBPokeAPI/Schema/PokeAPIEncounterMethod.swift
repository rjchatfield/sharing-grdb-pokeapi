import SharingGRDB

/// Methods of encountering Pokemon (walking, surfing, etc.).
@Table("encounter_methods")
public struct PokeAPIEncounterMethod: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("identifier") public var identifier: String
    @Column("order") public var order: Int
}