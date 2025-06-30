import StructuredQueries
import Tagged

/// Base stat values for Pokemon species in Pokemon Conquest's tactical battle system.
/// These stats are adapted for the grid-based tactical combat rather than traditional battles.
/// Pokemon have different stat distributions in Conquest compared to main series games.
@Table("conquest_pokemon_stats")
public struct PokeAPIConquestPokemonStat: Decodable, Hashable, Sendable {

    /// The Pokemon species these stats belong to
    /// Each species has its own stat spread in Conquest
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    /// The type of stat (Attack, Defense, Speed, Range, Health)
    /// Links to Conquest's simplified stat system
    @Column("conquest_stat_id") public var conquestStatId: PokeAPIConquestStat.ID

    /// The base value for this stat for this Pokemon species
    /// Determines the Pokemon's effectiveness in tactical combat
    @Column("base_stat") public var baseStat: Int

}