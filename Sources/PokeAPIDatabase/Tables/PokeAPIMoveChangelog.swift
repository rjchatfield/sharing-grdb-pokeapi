import StructuredQueries
import Tagged

/// Records changes made to moves across different version groups.
/// This table tracks the evolution of move properties (power, accuracy, PP, etc.)
/// as they were modified in different game versions.
@Table("move_changelog")
public struct PokeAPIMoveChangelog: Decodable, Hashable, Sendable {

    /// Reference to the move that was changed
    @Column("move_id") public var moveId: PokeAPIMove.ID

    /// Reference to the version group in which the change occurred
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

    /// The move's type after the change (nil if type wasn't changed)
    @Column("type_id") public var typeId: PokeAPIType.ID?

    /// The move's power after the change (nil if power wasn't changed)
    @Column("power") public var power: Int?

    /// The move's PP (Power Points) after the change (nil if PP wasn't changed)
    @Column("pp") public var pp: Int?

    /// The move's accuracy percentage after the change (nil if accuracy wasn't changed)
    @Column("accuracy") public var accuracy: Int?

    /// The move's priority after the change (nil if priority wasn't changed)
    @Column("priority") public var priority: Int?

    /// Reference to the move's target after the change (nil if target wasn't changed)
    @Column("target_id") public var targetId: PokeAPIMoveTarget.ID?

    /// Reference to the move's effect after the change (nil if effect wasn't changed)
    @Column("effect_id") public var effectId: PokeAPIMoveEffect.ID?

    /// The percentage chance of the move's effect occurring after the change (nil if effect chance wasn't changed)
    @Column("effect_chance") public var effectChance: Int?

}
