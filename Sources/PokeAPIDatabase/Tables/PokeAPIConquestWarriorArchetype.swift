import StructuredQueries
import Tagged

// TODO: Add description for conquest_warrior_archetypes table
@Table("conquest_warrior_archetypes")
public struct PokeAPIConquestWarriorArchetype: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}