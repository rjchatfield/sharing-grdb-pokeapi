import StructuredQueries
import Tagged

// TODO: Add description for conquest_warrior_ranks table
@Table("conquest_warrior_ranks")
public struct PokeAPIConquestWarriorRank: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for warrior_id
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

    // TODO: Add description for rank
    @Column("rank") public var rank: Int

    // TODO: Add description for skill_id
    @Column("skill_id") public var skillId: PokeAPIConquestWarriorSkill.ID

}