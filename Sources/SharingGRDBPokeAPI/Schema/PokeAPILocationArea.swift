import SharingGRDB

/// Specific areas within locations.
@Table("location_areas")
public struct PokeAPILocationArea: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("location_id") public var locationId: Int
    @Column("game_index") public var gameIndex: Int
    @Column("identifier") public var identifier: String
}