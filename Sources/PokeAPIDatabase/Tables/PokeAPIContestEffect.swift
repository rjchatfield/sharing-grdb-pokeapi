import StructuredQueries
import Tagged

/// Effects that moves can have in Pokemon Contests (Ruby/Sapphire/Emerald).
/// Each effect specifies appeal points gained and jam points inflicted on opponents.
/// Used to determine contest performance and audience reactions.
@Table("contest_effects")
public struct PokeAPIContestEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// Unique contest effect identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Appeal points this effect grants during contests
    /// Higher values increase the chance of winning contest rounds
    /// Range: typically 0-8
    @Column("appeal") public var appeal: Int

    /// Jam points this effect inflicts on opponents
    /// Reduces opponents' appeal in the same turn
    /// Range: typically 0-4
    @Column("jam") public var jam: Int

}