import StructuredQueries
import Tagged

// TODO: Add description for conquest_max_links table
@Table("conquest_max_links")
public struct PokeAPIConquestMaxLink: Decodable, Hashable, Sendable {

    // TODO: Add description for warrior_rank_id
    @Column("warrior_rank_id") public var warriorRankId: PokeAPIConquestWarriorRank.ID

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for max_link
    @Column("max_link") public var maxLink: Int

}