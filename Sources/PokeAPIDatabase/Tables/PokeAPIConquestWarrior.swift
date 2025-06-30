import StructuredQueries
import Tagged

/// Warriors from Pokemon Conquest, the tactical RPG spin-off game.
/// Each warrior is a human character that can form bonds with Pokemon
/// and lead them in strategic battles across the Ransei region.
@Table("conquest_warriors")
public struct PokeAPIConquestWarrior: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this Conquest warrior
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable warrior name (e.g., "nobunaga", "oichi", "hideyoshi")
    /// Based on historical Japanese figures
    @Column("identifier") public var identifier: Identifier

    /// The warrior's gender (male or female)
    /// Affects certain Pokemon compatibility and story elements
    @Column("gender_id") public var genderId: PokeAPIGender.ID

    /// References the warrior archetype that defines their combat role
    /// Determines stat growth patterns and strategic specializations
    @Column("archetype_id") public var archetypeId: PokeAPIConquestWarriorArchetype.ID?

}
