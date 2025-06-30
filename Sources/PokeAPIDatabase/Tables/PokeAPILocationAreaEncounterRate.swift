import StructuredQueries
import Tagged

/// Defines encounter rates for different methods in specific location areas and game versions.
/// Specifies the percentage chance of encountering wild Pokemon using various methods
/// like walking, surfing, or fishing in a particular area of a location.
@Table("location_area_encounter_rates")
public struct PokeAPILocationAreaEncounterRate: Decodable, Hashable, Sendable {

    /// References the specific location area where encounters occur
    /// Links to subdivisions of locations (e.g., "Route 1 area", "Viridian Forest entrance")
    @Column("location_area_id") public var locationAreaId: PokeAPILocationArea.ID

    /// References the encounter method this rate applies to
    /// Links to interaction types like walking, surfing, fishing, or headbutting
    @Column("encounter_method_id") public var encounterMethodId: PokeAPIEncounterMethod.ID

    /// References the game version this encounter rate applies to
    /// Different versions may have different encounter rates for the same area and method
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    /// The encounter rate as a percentage or probability value
    /// Represents the chance of a wild Pokemon encounter occurring with this method
    @Column("rate") public var rate: Int

}