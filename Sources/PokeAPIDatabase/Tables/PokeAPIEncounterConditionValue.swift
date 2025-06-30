import StructuredQueries
import Tagged

// TODO: Add description for encounter_condition_values table
@Table("encounter_condition_values")
public struct PokeAPIEncounterConditionValue: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for encounter_condition_id
    @Column("encounter_condition_id") public var encounterConditionId: PokeAPIEncounterCondition.ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for is_default
    @Column("is_default") public var isDefault: Int

}