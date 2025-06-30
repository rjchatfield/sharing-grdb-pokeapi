import StructuredQueries
import Tagged

/// Warrior progression ranks in Pokemon Conquest showing how warriors evolve and gain new abilities.
/// Warriors can achieve different ranks through story progression and battlefield accomplishments.
/// Each rank unlocks new skills and may change the warrior's appearance and capabilities.
@Table("conquest_warrior_ranks")
public struct PokeAPIConquestWarriorRank: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// The primary key identifier for this warrior rank entry
    @Column("id", primaryKey: true) public var id: ID

    /// References the warrior who can achieve this rank
    /// Each warrior may have multiple possible ranks they can reach
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

    /// The rank level (typically 1 or 2)
    /// Higher ranks represent evolved forms with enhanced abilities and stats
    @Column("rank") public var rank: Int

    /// The skill unlocked at this rank
    /// Higher ranks often grant more powerful or additional skills
    @Column("skill_id") public var skillId: PokeAPIConquestWarriorSkill.ID

}