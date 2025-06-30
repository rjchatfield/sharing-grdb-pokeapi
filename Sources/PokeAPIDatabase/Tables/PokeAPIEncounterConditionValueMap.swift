import StructuredQueries
import Tagged

/// Junction table linking specific encounters to their required condition values.
/// Defines which environmental conditions must be met for a particular encounter to occur,
/// such as time of day, weather, or seasonal requirements.
@Table("encounter_condition_value_map")
public struct PokeAPIEncounterConditionValueMap: Decodable, Hashable, Sendable {

    /// References the specific encounter record this condition applies to
    /// Links to the encounter data with Pokemon, location, and rate information
    @Column("encounter_id") public var encounterId: PokeAPIEncounter.ID

    /// References the specific condition value required for this encounter
    /// Links to the exact condition requirement (e.g., "night", "rain", "swarm")
    @Column("encounter_condition_value_id") public var encounterConditionValueId: PokeAPIEncounterConditionValue.ID

}