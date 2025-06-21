import StructuredQueries

/// Represents where and how wild Pokemon can be encountered in the game world.
/// Includes encounter rates, level ranges, and specific location areas.
/// Different game versions may have different encounter tables for the same location.
@Table("encounters")
public struct PokeAPIEncounter: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique encounter record identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Game version this encounter data applies to
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    /// Specific area within a location where this encounter occurs
    @Column("location_area_id") public var locationAreaId: PokeAPILocationArea.ID

    /// Encounter method and rarity slot (determines encounter rate)
    @Column("encounter_slot_id") public var encounterSlotId: PokeAPIEncounterSlot.ID

    /// Pokemon species that can be encountered
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// Minimum level this Pokemon can be encountered at
    @Column("min_level") public var minLevel: Int

    /// Maximum level this Pokemon can be encountered at
    @Column("max_level") public var maxLevel: Int
}
