import StructuredQueries
import Tagged

// TODO: Add description for conquest_pokemon_moves table
@Table("conquest_pokemon_moves")
public struct PokeAPIConquestPokemonMove: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

}