import StructuredQueries
import Tagged

// TODO: Add description for pokemon_form_types table
@Table("pokemon_form_types")
public struct PokeAPIPokemonFormType: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_form_id
    @Column("pokemon_form_id") public var pokemonFormId: PokeAPIPokemonForm.ID

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID

    // TODO: Add description for slot
    @Column("slot") public var slot: Int

}