import StructuredQueries
import Tagged

// TODO: Add description for ability_changelog table
@Table("ability_changelog")
public struct PokeAPIAbilityChangelog: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for ability_id
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID

    // TODO: Add description for changed_in_version_group_id
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

}