import StructuredQueries
import Tagged

/// Specific values for encounter conditions that must be met for certain Pokemon to appear.
/// For example, if the condition is "time", values might be "morning", "day", or "night".
/// Links specific condition requirements to wild Pokemon encounters.
@Table("encounter_condition_values")
public struct PokeAPIEncounterConditionValue: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this encounter condition value
    @Column("id", primaryKey: true) public var id: ID

    /// References the encounter condition this value belongs to
    /// Links to the parent condition category (e.g., "time", "season")
    @Column("encounter_condition_id") public var encounterConditionId: PokeAPIEncounterCondition.ID

    /// Machine-readable value name (e.g., "morning", "day", "night", "spring", "summer")
    /// Used to specify the exact condition requirement
    @Column("identifier") public var identifier: Identifier

    /// Whether this is the default value for encounters when no specific condition is set
    /// True for standard encounter conditions, false for special requirements
    @Column("is_default") public var isDefault: Bool

}