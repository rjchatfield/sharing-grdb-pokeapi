import StructuredQueries
import Tagged

// TODO: Add description for version_group_pokemon_move_methods table
@Table("version_group_pokemon_move_methods")
public struct PokeAPIVersionGroupPokemonMoveMethod: Decodable, Hashable, Sendable {

    // TODO: Add description for version_group_id
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    // TODO: Add description for pokemon_move_method_id
    @Column("pokemon_move_method_id") public var pokemonMoveMethodId: PokeAPIPokemonMoveMethod.ID

}