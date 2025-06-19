import SharingGRDB

/// Type effectiveness chart (super effective, not very effective, etc.).
@Table("type_efficacy")
public struct PokeAPITypeEfficacy: Decodable, Equatable, Sendable {
    @Column("damage_type_id") public var damageTypeId: Int
    @Column("target_type_id") public var targetTypeId: Int
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
