import StructuredQueries
import Tagged

/// Move data specific to Pokemon Conquest's tactical battle system.
/// Moves have different properties in Conquest compared to main series games,
/// including tactical range patterns and displacement effects for grid-based combat.
@Table("conquest_move_data")
public struct PokeAPIConquestMoveData: Decodable, Hashable, Sendable {

    /// The move this data applies to
    /// References a move from the main move database
    @Column("move_id") public var moveId: PokeAPIMove.ID

    /// The move's power/damage in Conquest battles
    /// May differ from the main series game power
    @Column("power") public var power: Int?

    /// The move's accuracy percentage in Conquest
    /// Determines hit chance in tactical combat
    @Column("accuracy") public var accuracy: Int?

    /// Percentage chance for the move's special effect to trigger
    /// Some moves have secondary effects with probability
    @Column("effect_chance") public var effectChance: Int?

    /// The special effect this move has in Conquest battles
    /// Links to Conquest-specific move effects
    @Column("effect_id") public var effectId: PokeAPIConquestMoveEffect.ID

    /// The tactical range pattern this move uses
    /// Determines which grid squares the move can target
    @Column("range_id") public var rangeId: PokeAPIConquestMoveRange.ID

    /// Optional displacement effect that moves Pokemon on the battlefield
    /// Some moves can push or pull units to different positions
    @Column("displacement_id") public var displacementId: PokeAPIConquestMoveDisplacement.ID?

}
