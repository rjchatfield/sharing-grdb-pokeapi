import StructuredQueries
import Tagged

/// Junction table mapping moves to their associated flags.
/// This table establishes the many-to-many relationship between moves and flags,
/// indicating which special properties and behaviors apply to each move.
@Table("move_flag_map")
public struct PokeAPIMoveFlagMap: Decodable, Hashable, Sendable {

    /// Reference to the move that has this flag
    @Column("move_id") public var moveId: PokeAPIMove.ID

    /// Reference to the flag that applies to this move
    @Column("move_flag_id") public var moveFlagId: PokeAPIMoveFlag.ID

}