import StructuredQueries
import Tagged

// TODO: Add description for location_area_encounter_rates table
@Table("location_area_encounter_rates")
public struct PokeAPILocationAreaEncounterRate: Decodable, Hashable, Sendable {

    // TODO: Add description for location_area_id
    @Column("location_area_id") public var locationAreaId: PokeAPILocationArea.ID

    // TODO: Add description for encounter_method_id
    @Column("encounter_method_id") public var encounterMethodId: PokeAPIEncounterMethod.ID

    // TODO: Add description for version_id
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    // TODO: Add description for rate
    @Column("rate") public var rate: Int

}