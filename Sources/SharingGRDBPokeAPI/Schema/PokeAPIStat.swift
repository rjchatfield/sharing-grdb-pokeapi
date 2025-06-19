import SharingGRDB

/// Stat definitions (HP, Attack, Defense, etc.).
@Table("stats")
public struct PokeAPIStat: Decodable, Equatable, Identifiable, Sendable {
    @Column("id", primaryKey: true) public var id: Int
    @Column("damage_class_id") public var damageClassId: Int?
    @Column("identifier") public var identifier: String
    @Column("is_battle_only") public var isBattleOnly: Bool
    @Column("game_index") public var gameIndex: Int?
    
    public var formattedName: String {
        switch identifier {
        case "hp": return "HP"
        case "attack": return "Attack"
        case "defense": return "Defense"
        case "special-attack": return "Sp. Attack"
        case "special-defense": return "Sp. Defense"
        case "speed": return "Speed"
        case "accuracy": return "Accuracy"
        case "evasion": return "Evasion"
        default: return identifier.capitalized.replacingOccurrences(of: "-", with: " ")
        }
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
