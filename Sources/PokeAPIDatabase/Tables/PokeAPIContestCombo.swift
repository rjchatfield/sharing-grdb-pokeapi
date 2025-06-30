import StructuredQueries
import Tagged

// TODO: Add description for contest_combos table
@Table("contest_combos")
public struct PokeAPIContestCombo: Decodable, Hashable, Sendable {

    // TODO: Add description for first_move_id
    @Column("first_move_id") public var firstMoveId: PokeAPIMove.ID

    // TODO: Add description for second_move_id
    @Column("second_move_id") public var secondMoveId: PokeAPIMove.ID

}