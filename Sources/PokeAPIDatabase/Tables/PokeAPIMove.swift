import StructuredQueries
import Tagged

/// Represents all Pokemon moves with their battle mechanics and properties.
/// Moves are learned by Pokemon and used in battle to deal damage, inflict status,
/// or provide other effects. Each move has type, power, accuracy, and special effects.
@Table("moves")
public struct PokeAPIMove: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique move identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable move name (e.g., "tackle", "thunderbolt", "hyper-beam")
    @Column("identifier") public var identifier: Identifier
    
    /// Generation in which this move was first introduced (1-9+)
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// Type of this move (Fire, Water, Electric, etc.)
    /// Determines effectiveness and STAB eligibility
    @Column("type_id") public var typeId: PokeAPIType.ID

    /// Base power of the move (typically 0-250)
    /// Nil for status moves that don't deal direct damage
    /// Range: 0-250
    @Column("power") public var power: Int?
    
    /// Power Points - number of times this move can be used (1-40)
    /// Nil for moves with unlimited uses (very rare)
    /// Range: 1-40
    @Column("pp") public var pp: Int?
    
    /// Hit accuracy as a percentage (0-100, some moves >100)
    /// Nil for moves that never miss (e.g., Swift)
    /// Range: 0-100
    @Column("accuracy") public var accuracy: Int?
    
    /// Move priority (-6 to +5, 0 is normal)
    /// Higher priority moves go first regardless of Speed
    /// Range: -7 to 5
    @Column("priority") public var priority: Int
    
    /// What the move can target (single enemy, all enemies, self, etc.)
    @Column("target_id") public var targetId: Int

    /// Physical, Special, or Status damage class
    /// Determines which Attack/Defense stats are used
    @Column("damage_class_id") public var damageClassId: PokeAPIMoveDamageClass.ID

    /// Primary effect this move has (damage, status condition, stat change, etc.)
    @Column("effect_id") public var effectId: Int?

    /// Percentage chance the secondary effect occurs (0-100)
    /// Nil if move has no secondary effect or always triggers
    /// Range: 10-100
    @Column("effect_chance") public var effectChance: Int?
    
    /// Contest type for Pokemon Contests (Cool, Beauty, Cute, Smart, Tough)
    @Column("contest_type_id") public var contestTypeId: Int?

    /// Effect this move has in Pokemon Contests
    @Column("contest_effect_id") public var contestEffectId: Int?
    
    /// Effect this move has in Super Contests (Diamond/Pearl/Platinum)
    @Column("super_contest_effect_id") public var superContestEffectId: Int?

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.move(id: id, identifier: identifier)
    }
}
