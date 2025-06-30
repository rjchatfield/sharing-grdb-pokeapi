import StructuredQueries
import Tagged

/// Pokemon species involved in warrior transformation requirements in Pokemon Conquest.
/// Some warrior transformations require the presence of specific Pokemon species
/// or achieving certain bond levels with particular Pokemon types.
@Table("conquest_transformation_pokemon")
public struct PokeAPIConquestTransformationPokemon: Decodable, Hashable, Sendable {

    /// References the transformation this Pokemon requirement applies to
    /// Links to a specific warrior transformation condition
    @Column("transformation_id") public var transformationId: Int

    /// The Pokemon species that must be involved in this transformation
    /// May require owning, bonding with, or having this species present
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

}