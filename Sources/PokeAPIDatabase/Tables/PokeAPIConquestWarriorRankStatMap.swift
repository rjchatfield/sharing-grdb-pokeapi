import StructuredQueries
import Tagged

// TODO: Add description for conquest_warrior_rank_stat_map table
@Table("conquest_warrior_rank_stat_map")
public struct PokeAPIConquestWarriorRankStatMap: Decodable, Hashable, Sendable {

    // TODO: Add description for warrior_rank_id
    @Column("warrior_rank_id") public var warriorRankId: PokeAPIConquestWarriorRank.ID

    // TODO: Add description for warrior_stat_id
    @Column("warrior_stat_id") public var warriorStatId: PokeAPIConquestWarriorStat.ID

    // TODO: Add description for base_stat
    @Column("base_stat") public var baseStat: Int

}