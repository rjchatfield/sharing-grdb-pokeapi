import StructuredQueries
import Tagged

/// Historical type effectiveness data from previous generations where matchups differed.
/// Tracks how type effectiveness has changed over time as the games have been rebalanced,
/// such as Steel type not resisting Dark/Ghost in Generation 1 or other type chart changes.
@Table("type_efficacy_past")
public struct PokeAPITypeEfficacyPast: Decodable, Hashable, Sendable {

    /// References the attacking type in this historical effectiveness matchup
    /// The type of the move being used in the damage calculation
    @Column("damage_type_id") public var damageTypeId: PokeAPIType.ID

    /// References the defending type in this historical effectiveness matchup
    /// The type of the Pokemon receiving the attack
    @Column("target_type_id") public var targetTypeId: PokeAPIType.ID

    /// The damage multiplier for this type matchup in past generations
    /// Values like 0 (no effect), 50 (not very effective), 100 (normal), 200 (super effective)
    @Column("damage_factor") public var damageFactor: Int

    /// References the generation where this type effectiveness applied
    /// Indicates which game generation used this specific type matchup
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

}