import StructuredQueries
import Tagged

/// Junction table linking version groups to available Pokemon move learning methods.
/// Defines which methods of learning moves are available in each set of game versions,
/// such as leveling up, TMs, tutors, or breeding being introduced in different generations.
@Table("version_group_pokemon_move_methods")
public struct PokeAPIVersionGroupPokemonMoveMethod: Decodable, Hashable, Sendable {

    /// References the version group where this move learning method is available
    /// Links to the set of games that support this method of learning moves
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    /// References the specific method of learning moves
    /// Links to learning methods like level-up, TM, HM, tutor, egg, or machine
    @Column("pokemon_move_method_id") public var pokemonMoveMethodId: PokeAPIPokemonMoveMethod.ID

}