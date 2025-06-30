import StructuredQueries
import Tagged

/// Pokedex entry numbers for Pokemon in different regional Pokedexes
@Table("pokemon_dex_numbers")
public struct PokeAPIPokemonDexNumber: Decodable, Hashable, Sendable {
    /// Foreign key to species
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecies.ID

    /// Foreign key to pokedex
    @Column("pokedex_id") public var pokedexId: PokeAPIPokedex.ID

    /// Pokedex number
    @Column("pokedex_number") public var pokedexNumber: Int
}
