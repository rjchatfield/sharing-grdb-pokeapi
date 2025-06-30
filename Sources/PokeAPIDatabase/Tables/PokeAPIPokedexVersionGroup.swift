import StructuredQueries
import Tagged

/// Maps Pokedexes to the version groups where they are available.
/// Each Pokedex can appear in multiple version groups, and each version group
/// can have multiple Pokedexes (regional, national, etc.).
@Table("pokedex_version_groups")
public struct PokeAPIPokedexVersionGroup: Decodable, Hashable, Sendable {

    /// Reference to the Pokedex that is available in the version group
    @Column("pokedex_id") public var pokedexId: PokeAPIPokedex.ID

    /// Reference to the version group where this Pokedex is available
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

}