import StructuredQueries
import Tagged

/// Environmental and temporal conditions that affect Pokemon encounters.
/// Defines requirements like time of day, weather, season, or special events
/// that must be met for certain Pokemon to appear in the wild.
@Table("encounter_conditions")
public struct PokeAPIEncounterCondition: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this encounter condition
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable condition name ("time", "season", "radio", etc.)
    /// Used to categorize encounter requirements
    @Column("identifier") public var identifier: Identifier

}