import StructuredQueries
import Tagged

/// Maps Pokemon natures to their effects on Pokeathlon statistics.
/// Each nature can modify specific Pokeathlon stats (Speed, Power, Technique, Stamina, Jump)
/// by positive or negative amounts, affecting performance in Pokeathlon events.
@Table("nature_pokeathlon_stats")
public struct PokeAPINaturePokeathlonStat: Decodable, Hashable, Sendable {

    /// Reference to the nature that affects this Pokeathlon statistic
    @Column("nature_id") public var natureId: PokeAPINature.ID

    /// Reference to the Pokeathlon statistic being modified
    @Column("pokeathlon_stat_id") public var pokeathlonStatId: PokeAPIPokeathlonStat.ID

    /// Maximum change this nature applies to the Pokeathlon stat
    /// Positive values increase the stat, negative values decrease it
    @Column("max_change") public var maxChange: Int

}