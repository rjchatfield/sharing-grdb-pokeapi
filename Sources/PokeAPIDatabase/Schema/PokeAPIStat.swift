import StructuredQueries
import Tagged

/// Defines the core stats used throughout Pokemon games.
/// The main six stats are HP, Attack, Defense, Special Attack, Special Defense, and Speed.
/// Additional stats like Accuracy and Evasion exist for battle calculations.
@Table("stats")
public struct PokeAPIStat: Decodable, Equatable, Identifiable, Sendable {
    public enum ID: Int, Sendable, Decodable {
        case hp = 1
        case attack
        case defense
        case specialAttack
        case specialDefense
        case speed
        case accuracy
        case evasion
    }

    public enum Identifier: String, Sendable, Decodable {
        case hp = "hp"
        case attack = "attack"
        case defense = "defense"
        case specialAttack = "special-attack"
        case specialDefense = "special-defense"
        case speed = "speed"
        case accuracy = "accuracy"
        case evasion = "evasion"
    }

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
        return PokeAPIStrings.stat(id: id)
    }
}

// MARK: - 

extension PokeAPIStat.ID {
    public var identifier: PokeAPIStat.Identifier {
        switch self {
        case .hp: return .hp
        case .attack: return .attack
        case .defense: return .defense
        case .specialAttack: return .specialAttack
        case .specialDefense: return .specialDefense
        case .speed: return .speed
        case .accuracy: return .accuracy
        case .evasion: return .evasion
        }
    }
}

extension PokeAPIStat.Identifier {
    public var id: PokeAPIStat.ID {
        switch self {
        case .hp: return .hp
        case .attack: return .attack
        case .defense: return .defense
        case .specialAttack: return .specialAttack
        case .specialDefense: return .specialDefense
        case .speed: return .speed
        case .accuracy: return .accuracy
        case .evasion: return .evasion
        }
    }

    public var abbreviation: String {
        switch self {
        case .hp: return "HP"
        case .attack: return "Atk"
        case .defense: return "Def"
        case .specialAttack: return "SpA"
        case .specialDefense: return "SpD"
        case .speed: return "Spe"
        case .accuracy: return "Acc"
        case .evasion: return "Eva"
        }
    }
}

// MARK: -

extension PokeAPIStat.ID: SQLiteType {
    public static var typeAffinity: SQLiteTypeAffinity { RawValue.typeAffinity }
}

// MARK: -

extension PokeAPIStat.Identifier: SQLiteType {
    public static var typeAffinity: SQLiteTypeAffinity { RawValue.typeAffinity }
}
