import StructuredQueries

/// Represents specific Pokemon game cartridges/titles within version groups.
/// Each version may have exclusive Pokemon, different encounter rates, or unique features
/// while sharing core mechanics with other versions in the same group.
@Table("versions")
public struct PokeAPIVersion: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique version identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Version group this individual game belongs to
    /// Links related versions like Red/Blue or Diamond/Pearl together
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID
    
    /// Machine-readable version name (e.g., "red", "blue", "gold", "silver", "diamond")
    /// Individual game cartridge or digital release identifier
    @Column("identifier") public var identifier: String
}
