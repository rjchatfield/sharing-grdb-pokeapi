import SharingGRDB

/// Encounter slot definitions with rarity.
@Table("encounter_slots")
public struct PokeAPIEncounterSlot: Decodable, Hashable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("version_group_id") public var versionGroupId: Int
    @Column("encounter_method_id") public var encounterMethodId: Int
    @Column("slot") public var slot: Int
    @Column("rarity") public var rarity: Int
}