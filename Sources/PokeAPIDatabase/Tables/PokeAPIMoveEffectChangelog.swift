import StructuredQueries
import Tagged

/// Records changes made to move effects across different version groups.
/// This table tracks when move effects were modified, added, or updated
/// in different game versions, maintaining a history of effect evolution.
@Table("move_effect_changelog")
public struct PokeAPIMoveEffectChangelog: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// Unique identifier for the move effect changelog entry
    @Column("id", primaryKey: true) public var id: ID

    /// Reference to the move effect that was changed
    @Column("effect_id") public var effectId: PokeAPIMoveEffect.ID

    /// Reference to the version group in which the effect change occurred
    @Column("changed_in_version_group_id") public var changedInVersionGroupId: PokeAPIVersionGroup.ID

}