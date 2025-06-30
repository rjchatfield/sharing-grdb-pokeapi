import StructuredQueries
import Tagged

/// Maps warrior ranks to their specific stat values in Pokemon Conquest.
/// Each warrior rank has defined base stats that determine their combat effectiveness.
/// This allows warriors to have different stat spreads at different ranks.
@Table("conquest_warrior_rank_stat_map")
public struct PokeAPIConquestWarriorRankStatMap: Decodable, Hashable, Sendable {

    /// References the specific warrior rank for these stats
    /// Each rank of each warrior has its own stat spread
    @Column("warrior_rank_id") public var warriorRankId: PokeAPIConquestWarriorRank.ID

    /// The type of stat being mapped (Attack, Defense, Speed, etc.)
    /// Links to the conquest warrior stat types
    @Column("warrior_stat_id") public var warriorStatId: PokeAPIConquestWarriorStat.ID

    /// The base value for this stat at this warrior rank
    /// Higher ranks typically have improved stats
    @Column("base_stat") public var baseStat: Int

}