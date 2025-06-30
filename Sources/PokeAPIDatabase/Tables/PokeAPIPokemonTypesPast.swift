import StructuredQueries
import Tagged

// TODO: Add description for pokemon_types_past table
@Table("pokemon_types_past")
public struct PokeAPIPokemonTypesPast: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_id
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    // TODO: Add description for generation_id
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID

    // TODO: Add description for slot
    @Column("slot") public var slot: Int

}