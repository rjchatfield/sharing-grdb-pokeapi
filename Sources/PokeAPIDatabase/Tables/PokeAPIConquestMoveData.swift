import StructuredQueries
import Tagged

// TODO: Add description for conquest_move_data table
@Table("conquest_move_data")
public struct PokeAPIConquestMoveData: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for power
    @Column("power") public var power: Int?

    // TODO: Add description for accuracy
    @Column("accuracy") public var accuracy: Int?

    // TODO: Add description for effect_chance
    @Column("effect_chance") public var effectChance: Int?

    // TODO: Add description for effect_id
    @Column("effect_id") public var effectId: PokeAPIConquestMoveEffect.ID

    // TODO: Add description for range_id
    @Column("range_id") public var rangeId: PokeAPIConquestMoveRange.ID

    // TODO: Add description for displacement_id
    @Column("displacement_id") public var displacementId: PokeAPIConquestMoveDisplacement.ID?

}
