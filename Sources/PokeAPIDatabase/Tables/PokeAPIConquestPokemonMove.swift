import StructuredQueries
import Tagged

/// Moves that Pokemon species can learn and use in Pokemon Conquest battles.
/// Unlike main series games, Pokemon in Conquest typically know only one move at a time.
/// Move selection is crucial for tactical positioning and combat effectiveness.
@Table("conquest_pokemon_moves")
public struct PokeAPIConquestPokemonMove: Decodable, Hashable, Sendable {

    /// The Pokemon species that can learn this move
    /// Each species has a limited set of available moves in Conquest
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    /// The move that this Pokemon species can learn
    /// References the specific move from the main move database
    @Column("move_id") public var moveId: PokeAPIMove.ID

}