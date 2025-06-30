import StructuredQueries
import Tagged

// TODO: Add description for version_group_regions table
@Table("version_group_regions")
public struct PokeAPIVersionGroupRegion: Decodable, Hashable, Sendable {

    // TODO: Add description for version_group_id
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    // TODO: Add description for region_id
    @Column("region_id") public var regionId: PokeAPIRegion.ID

}