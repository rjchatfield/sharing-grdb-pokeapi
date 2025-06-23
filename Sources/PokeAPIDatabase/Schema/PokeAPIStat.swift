import StructuredQueries
import Tagged

/// Defines the core stats used throughout Pokemon games.
/// The main six stats are HP, Attack, Defense, Special Attack, Special Defense, and Speed.
/// Additional stats like Accuracy and Evasion exist for battle calculations.
@Table("stats")
public struct PokeAPIStat: Decodable, Equatable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique stat identifier (1=HP, 2=Attack, 3=Defense, 4=Sp.Attack, 5=Sp.Defense, 6=Speed)
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable stat name (e.g., "hp", "attack", "special-defense")
    @Column("identifier") public var identifier: Identifier

    /// Move damage class this stat affects (Physical/Special/Status)
    /// Attack affects Physical, Special Attack affects Special, nil for others
    @Column("damage_class_id") public var damageClassId: PokeAPIMoveDamageClass.ID?

    /// Whether this stat only exists during battle (true for Accuracy/Evasion)
    /// Main six stats are permanent, others are temporary battle modifiers
    @Column("is_battle_only") public var isBattleOnly: Bool
    
    /// In-game index number for this stat (used internally by game mechanics)
    /// Range: 1-6
    @Column("game_index") public var gameIndex: Int?

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.stat(id: id, identifier: identifier)
            .replacingOccurrences(of: "Special", with: "Sp.")
    }
    
    public var abbreviation: String {
        switch identifier {
        case "hp": return "HP"
        case "attack": return "Atk"
        case "defense": return "Def"
        case "special-attack": return "SpA"
        case "special-defense": return "SpD"
        case "speed": return "Spe"
        case "accuracy": return "Acc"
        case "evasion": return "Eva"
        default: return String(identifier.prefix(3).capitalized)
        }
    }
}
