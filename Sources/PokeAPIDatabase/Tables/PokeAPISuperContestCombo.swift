import StructuredQueries
import Tagged

/// Move combinations that provide bonus appeal in Super Contests (Diamond/Pearl/Platinum).
/// Similar to regular contest combos but designed for the enhanced super contest format.
/// When moves are used in sequence, the second move receives enhanced appeal.
@Table("super_contest_combos")
public struct PokeAPISuperContestCombo: Decodable, Hashable, Sendable {

    /// The first move that must be used to set up the super contest combo
    /// References the moves table
    @Column("first_move_id") public var firstMoveId: PokeAPIMove.ID

    /// The second move that receives the combo bonus in super contests
    /// Must be used after the first move to activate the bonus
    /// References the moves table
    @Column("second_move_id") public var secondMoveId: PokeAPIMove.ID

}