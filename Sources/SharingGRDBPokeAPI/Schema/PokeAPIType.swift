import SharingGRDB

/// Represents the 18 Pokemon types (Normal, Fire, Water, Electric, etc.).
/// Types determine move effectiveness, resistances, and STAB (Same Type Attack Bonus).
/// Each type has unique interactions with other types in the type effectiveness chart.
@Table("types")
public struct PokeAPIType: Decodable, Equatable, Identifiable, Sendable {
    /// Unique type identifier (1-18 for main types)
    @Column("id", primaryKey: true) public var id: Int
    
    /// Machine-readable type name (e.g., "normal", "fire", "water", "electric")
    @Column("identifier") public var identifier: String
    
    /// Generation in which this type was introduced
    /// Most types from Gen 1, Dark/Steel from Gen 2, Fairy from Gen 6
    @Column("generation_id") public var generation_id: Int
    
    /// Default damage class for moves of this type (Physical/Special/Status)
    /// Used in older generations before individual moves had damage classes
    @Column("damage_class_id") public var damage_class_id: Int
}
