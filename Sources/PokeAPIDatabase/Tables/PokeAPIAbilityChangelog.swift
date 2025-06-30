import StructuredQueries
import Tagged

/// Historical record of ability changes and updates across game versions.
/// Tracks when abilities were modified, nerfed, buffed, or had their mechanics altered.
/// Important for understanding ability evolution and maintaining version compatibility.
@Table("ability_changelog")
public struct PokeAPIAbilityChangelog: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// The primary key identifier for this changelog entry
    @Column("id", primaryKey: true) public var id: ID

    /// References the ability that was changed in this version
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID

    /// The version group in which this ability change occurred
    /// Used to track when specific ability modifications were implemented
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

}