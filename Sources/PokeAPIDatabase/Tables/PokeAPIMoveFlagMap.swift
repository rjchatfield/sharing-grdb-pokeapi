import StructuredQueries
import Tagged

// TODO: Add description for move_flag_map table
@Table("move_flag_map")
public struct PokeAPIMoveFlagMap: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for move_flag_id
    @Column("move_flag_id") public var moveFlagId: PokeAPIMoveFlag.ID

}