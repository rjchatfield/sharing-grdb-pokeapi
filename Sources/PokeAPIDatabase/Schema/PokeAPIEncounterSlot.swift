import StructuredQueries

/// Defines probability slots for Pokemon encounters within specific methods and game versions.
/// Each slot represents a different rarity tier (common, uncommon, rare) with different
/// encounter rates. Multiple Pokemon can share the same slot, creating encounter tables.
@Table("encounter_slots")
public struct PokeAPIEncounterSlot: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique encounter slot identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Game version group this encounter slot applies to
    /// Different versions may have different encounter rates for the same location
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    /// Encounter method this slot is used for (walking, surfing, fishing, etc.)
    @Column("encounter_method_id") public var encounterMethodId: PokeAPIEncounterMethod.ID
    
    /// Slot number within the encounter method (typically 1-12)
    /// Lower slot numbers are usually more common encounters
    /// Range: 0-25
    @Column("slot") public var slot: Int
    
    /// Encounter rate/rarity percentage (0-100)
    /// Higher values mean more common encounters
    /// Example: slot 1 might be 20%, slot 2 might be 20%, rare slots might be 1%
    /// Range: 1-100
    @Column("rarity") public var rarity: Int
}
