import StructuredQueries
import Tagged

// TODO: Add description for conquest_warriors table
@Table("conquest_warriors")
public struct PokeAPIConquestWarrior: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for gender_id
    @Column("gender_id") public var genderId: PokeAPIGender.ID

    // TODO: Add description for archetype_id
    @Column("archetype_id") public var archetypeId: PokeAPIConquestWarriorArchetype.ID?

}
