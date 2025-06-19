import SharingGRDB

/// Defines the damage multipliers between attacking and defending Pokemon types.
/// This creates the rock-paper-scissors type system that's fundamental to Pokemon battles.
/// Default effectiveness is 1x; this table only stores non-default relationships.
@Table("type_efficacy")
public struct PokeAPITypeEfficacy: Decodable, Equatable, Sendable {
    /// The attacking type (e.g., Fire-type moves)
    @Column("damage_type_id") public var damageTypeId: Int
    
    /// The defending type being attacked (e.g., Grass-type Pokemon)
    @Column("target_type_id") public var targetTypeId: Int
    
    /// Damage multiplier as integer (0=no effect, 50=½x, 200=2x)
    /// Divide by 100 to get actual multiplier. Default 1x relationships are omitted.
    @Column("damage_factor") public var damageFactor: Int

    public var effectiveness: Double {
        Double(damageFactor) / 100.0
    }
    
    public var effectivenessDescription: String {
        switch effectiveness {
        case 0: return "No Effect"
        case 0.25: return "Not Very Effective (¼×)"
        case 0.5: return "Not Very Effective (½×)"
        case 1.0: return "Normal Effectiveness (1×)"
        case 2.0: return "Super Effective (2×)"
        case 4.0: return "Super Effective (4×)"
        default: return "\(effectiveness)×"
        }
    }
    
    public var isNoEffect: Bool { effectiveness == 0 }
    public var isNotVeryEffective: Bool { effectiveness < 1.0 && effectiveness > 0 }
    public var isSuperEffective: Bool { effectiveness > 1.0 }
    public var isNormalEffectiveness: Bool { effectiveness == 1.0 }
}
