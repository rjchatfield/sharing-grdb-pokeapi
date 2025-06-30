import StructuredQueries
import Tagged

/// Maps Pokemon natures to their preferred battle styles at different HP levels.
/// Natures influence AI behavior in battle, affecting move selection based on
/// whether the Pokemon has low or high HP remaining.
@Table("nature_battle_style_preferences")
public struct PokeAPINatureBattleStylePreference: Decodable, Hashable, Sendable {

    /// Reference to the nature that has this battle style preference
    @Column("nature_id") public var natureId: PokeAPINature.ID

    /// Reference to the preferred battle style for this nature
    @Column("move_battle_style_id") public var moveBattleStyleId: PokeAPIMoveBattleStyle.ID

    /// Preference value for this battle style when Pokemon has low HP
    /// Higher values indicate stronger preference for this battle style
    @Column("low_hp_preference") public var lowHpPreference: Int

    /// Preference value for this battle style when Pokemon has high HP
    /// Higher values indicate stronger preference for this battle style
    @Column("high_hp_preference") public var highHpPreference: Int

}