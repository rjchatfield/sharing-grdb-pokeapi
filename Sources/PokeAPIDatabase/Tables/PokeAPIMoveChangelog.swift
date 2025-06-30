import StructuredQueries
import Tagged

// TODO: Add description for move_changelog table
@Table("move_changelog")
public struct PokeAPIMoveChangelog: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for changed_in_version_group_id
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

    // TODO: Add description for type_id
    @Column("type_id") public var typeId: PokeAPIType.ID?

    // TODO: Add description for power
    @Column("power") public var power: Int?

    // TODO: Add description for pp
    @Column("pp") public var pp: Int?

    // TODO: Add description for accuracy
    @Column("accuracy") public var accuracy: Int?

    // TODO: Add description for priority
    @Column("priority") public var priority: Int?

    // TODO: Add description for target_id
    @Column("target_id") public var targetId: PokeAPIMoveTarget.ID?

    // TODO: Add description for effect_id
    @Column("effect_id") public var effectId: PokeAPIMoveEffect.ID?

    // TODO: Add description for effect_chance
    @Column("effect_chance") public var effectChance: Int?

}
