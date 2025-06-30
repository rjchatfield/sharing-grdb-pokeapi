import StructuredQueries
import Tagged

/// Effects that moves can have in Super Contests (Diamond/Pearl/Platinum).
/// Super Contests evolved from regular contests with more complex appeal mechanics.
/// Each effect specifies the appeal points gained during the visual performance round.
@Table("super_contest_effects")
public struct PokeAPISuperContestEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// Unique super contest effect identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Appeal points this effect grants during super contests
    /// Used in the visual performance round to determine rankings
    /// Range: typically 1-8
    @Column("appeal") public var appeal: Int

}