import StructuredQueries
import Tagged

// TODO: Add description for pokemon_form_generations table
@Table("pokemon_form_generations")
public struct PokeAPIPokemonFormGeneration: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_form_id
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for game_index
    @Column("game_index") public var gameIndex: Int

}