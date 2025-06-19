import SharingGRDB

/// Wild Pokemon encounter data.
@Table("encounters")
public struct PokeAPIEncounter: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("version_id") public var versionId: Int
    @Column("location_area_id") public var locationAreaId: Int
    @Column("encounter_slot_id") public var encounterSlotId: Int
    @Column("pokemon_id") public var pokemonId: Int
    @Column("min_level") public var minLevel: Int
    @Column("max_level") public var maxLevel: Int
}