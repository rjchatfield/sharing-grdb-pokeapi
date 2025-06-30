import StructuredQueries
import Tagged

/// Junction table linking version groups to their primary regions.
/// Defines which region is the main setting for a group of game versions,
/// such as Red/Blue taking place in Kanto or Gold/Silver in Johto.
@Table("version_group_regions")
public struct PokeAPIVersionGroupRegion: Decodable, Hashable, Sendable {

    /// References the version group (set of related game versions)
    /// Links to games released together with shared mechanics and regions
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    /// References the primary region where this version group takes place
    /// Links to the main geographical area featured in these games
    @Column("region_id") public var regionId: PokeAPIRegion.ID

}