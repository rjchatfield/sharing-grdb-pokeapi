import StructuredQueries
import Tagged

/// Move combinations that provide bonus appeal in Pokemon Contests.
/// When the first move is used followed by the second move in the next turn,
/// the second move receives an appeal bonus. Used in Ruby/Sapphire/Emerald contests.
@Table("contest_combos")
public struct PokeAPIContestCombo: Decodable, Hashable, Sendable {

    /// The first move that must be used to set up the combo
    /// References the moves table
    @Column("first_move_id") public var firstMoveId: PokeAPIMove.ID

    /// The second move that receives the combo bonus
    /// Must be used in the turn immediately after the first move
    /// References the moves table
    @Column("second_move_id") public var secondMoveId: PokeAPIMove.ID

}