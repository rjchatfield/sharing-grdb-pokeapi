import StructuredQueries
import Tagged

// TODO: Add description for move_effect_changelog table
@Table("move_effect_changelog")
public struct PokeAPIMoveEffectChangelog: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for effect_id
    @Column("effect_id") public var effectId: PokeAPIMoveEffect.ID

    // TODO: Add description for changed_in_version_group_id
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

}