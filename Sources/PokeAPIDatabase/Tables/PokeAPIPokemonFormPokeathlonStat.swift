import StructuredQueries
import Tagged

// TODO: Add description for pokemon_form_pokeathlon_stats table
@Table("pokemon_form_pokeathlon_stats")
public struct PokeAPIPokemonFormPokeathlonStat: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_form_id
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    // TODO: Add description for pokeathlon_stat_id
    @Column("pokeathlon_stat_id") public var pokeathlonStatId: PokeAPIPokeathlonStat.ID

    // TODO: Add description for minimum_stat
    @Column("minimum_stat") public var minimumStat: Int

    // TODO: Add description for base_stat
    @Column("base_stat") public var baseStat: Int

    // TODO: Add description for maximum_stat
    @Column("maximum_stat") public var maximumStat: Int

}