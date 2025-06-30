import StructuredQueries
import Tagged

/// Special abilities and skills that warriors can possess in Pokemon Conquest.
/// These skills provide passive bonuses during battle or overworld activities.
/// Examples include stat boosts, special movement abilities, or tactical advantages.
@Table("conquest_warrior_skills")
public struct PokeAPIConquestWarriorSkill: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Conquest warrior skill
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable skill name (e.g., "capacity", "charisma", "fortune")
    /// Skills are unique abilities that enhance warrior performance in various ways
    @Column("identifier") public var identifier: Identifier

}