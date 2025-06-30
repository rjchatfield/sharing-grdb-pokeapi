import StructuredQueries
import Tagged

// TODO: Add description for nature_battle_style_preferences table
@Table("nature_battle_style_preferences")
public struct PokeAPINatureBattleStylePreference: Decodable, Hashable, Sendable {

    // TODO: Add description for nature_id
    @Column("nature_id") public var natureId: PokeAPINature.ID

    // TODO: Add description for move_battle_style_id
    @Column("move_battle_style_id") public var moveBattleStyleId: PokeAPIMoveBattleStyle.ID

    // TODO: Add description for low_hp_preference
    @Column("low_hp_preference") public var lowHpPreference: Int

    // TODO: Add description for high_hp_preference
    @Column("high_hp_preference") public var highHpPreference: Int

}