import StructuredQueries
import Tagged

/// Pokeathlon performance statistics for specific Pokemon forms.
/// Defines min, base, and max values for each of the five Pokeathlon stats
/// (Speed, Power, Technique, Stamina, Jump) used in HeartGold/SoulSilver mini-games.
@Table("pokemon_form_pokeathlon_stats")
public struct PokeAPIPokemonFormPokeathlonStat: Decodable, Hashable, Sendable {

    /// Foreign key to the Pokemon form these Pokeathlon stats belong to
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    /// Foreign key to the specific Pokeathlon stat category
    /// (Speed, Power, Technique, Stamina, or Jump)
    @Column("pokeathlon_stat_id") public var pokeathlonStatId: PokeAPIPokeathlonStat.ID

    /// Minimum possible value for this stat in Pokeathlon events
    /// Base value when Pokemon has no stat-boosting items or training
    @Column("minimum_stat") public var minimumStat: Int

    /// Default base value for this Pokeathlon stat
    /// Starting point for calculations before items and training
    @Column("base_stat") public var baseStat: Int

    /// Maximum possible value for this stat in Pokeathlon events
    /// Achievable with optimal items and training
    @Column("maximum_stat") public var maximumStat: Int

}