import StructuredQueries
import Tagged

/// Maps Pokemon to their game-specific index numbers across different versions.
/// Each Pokemon may have different index numbers in different games
/// (e.g., Bulbasaur is #153 in Red/Blue but #1 in Gold/Silver).
@Table("pokemon_game_indices")
public struct PokeAPIPokemonGameIndices: Decodable, Hashable, Sendable {

    /// References the Pokemon that has this game-specific index
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// The specific game version where this index applies
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    /// The Pokemon's index number in this specific game version
    /// Used for internal game references and ordering
    @Column("game_index") public var gameIndex: Int

}