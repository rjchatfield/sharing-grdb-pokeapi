import StructuredQueries
import Tagged

// TODO: Add description for encounter_condition_value_map table
@Table("encounter_condition_value_map")
public struct PokeAPIEncounterConditionValueMap: Decodable, Hashable, Sendable {

    // TODO: Add description for encounter_id
    @Column("encounter_id") public var encounterId: PokeAPIEncounter.ID

    // TODO: Add description for encounter_condition_value_id
    @Column("encounter_condition_value_id") public var encounterConditionValueId: PokeAPIEncounterConditionValue.ID

}