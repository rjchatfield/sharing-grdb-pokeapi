import StructuredQueries
import Tagged

/// Junction table linking Pokemon species to their egg groups
@Table("pokemon_egg_groups")
public struct PokeAPIPokemonEggGroup: Decodable, Hashable, Sendable {
    /// Foreign key to species
    @Column("species_id") public var speciesId: PokeAPIPokemonSpecies.ID

    /// Foreign key to egg group
    @Column("egg_group_id") public var eggGroupId: PokeAPIEggGroup.ID
}
