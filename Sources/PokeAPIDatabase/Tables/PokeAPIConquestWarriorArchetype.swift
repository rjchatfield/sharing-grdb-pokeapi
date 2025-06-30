import StructuredQueries
import Tagged

/// Warrior combat archetypes in Pokemon Conquest that define strategic roles and stat distributions.
/// These archetypes determine how warriors fight and their compatibility with different Pokemon types.
/// Examples include "hero", "fighter", "strategist", each with unique strengths and weaknesses.
@Table("conquest_warrior_archetypes")
public struct PokeAPIConquestWarriorArchetype: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this warrior archetype
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable archetype name (e.g., "hero", "fighter", "strategist")
    /// Defines the warrior's combat role and tactical specialization
    @Column("identifier") public var identifier: Identifier

}