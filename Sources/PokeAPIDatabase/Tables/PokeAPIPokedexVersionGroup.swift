import StructuredQueries
import Tagged

// TODO: Add description for pokedex_version_groups table
@Table("pokedex_version_groups")
public struct PokeAPIPokedexVersionGroup: Decodable, Hashable, Sendable {

    // TODO: Add description for pokedex_id
    @Column("pokedex_id") public var pokedexId: PokeAPIPokedex.ID

    // TODO: Add description for version_group_id
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

}