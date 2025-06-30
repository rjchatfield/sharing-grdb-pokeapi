import StructuredQueries
import Tagged

// TODO: Add description for pokemon_game_indices table
@Table("pokemon_game_indices")
public struct PokeAPIPokemonGameIndices: Decodable, Hashable, Sendable {

    // TODO: Add description for pokemon_id
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    // TODO: Add description for version_id
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    // TODO: Add description for game_index
    @Column("game_index") public var gameIndex: Int

}