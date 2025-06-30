import StructuredQueries
import Tagged

// TODO: Add description for conquest_transformation_pokemon table
@Table("conquest_transformation_pokemon")
public struct PokeAPIConquestTransformationPokemon: Decodable, Hashable, Sendable {

    // TODO: Add description for transformation_id
    @Column("transformation_id") public var transformationId: Int

    // TODO: Add description for pokemon_species_id
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

}