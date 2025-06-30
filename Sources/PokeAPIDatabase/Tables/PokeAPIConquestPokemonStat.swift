import StructuredQueries
import Tagged

// TODO: Add description for conquest_pokemon_stats table
@Table("conquest_pokemon_stats")
public struct PokeAPIConquestPokemonStat: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for conquest_stat_id
    @Column("conquest_stat_id") public var conquestStatId: PokeAPIConquestStat.ID

    // TODO: Add description for base_stat
    @Column("base_stat") public var baseStat: Int

}