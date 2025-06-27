import StructuredQueries
import Tagged

/// Represents the 18 Pokemon types (Normal, Fire, Water, Electric, etc.).
/// Types determine move effectiveness, resistances, and STAB (Same Type Attack Bonus).
/// Each type has unique interactions with other types in the type effectiveness chart.
@Table("types")
public struct PokeAPIType: Decodable, Equatable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String
    
    /// Unique type identifier (1-18 for main types)
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable type name (e.g., "normal", "fire", "water", "electric")
    @Column("identifier") public var identifier: Identifier

    /// Generation in which this type was introduced
    /// Most types from Gen 1, Dark/Steel from Gen 2, Fairy from Gen 6
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// Default damage class for moves of this type (Physical/Special/Status)
    /// Used in older generations before individual moves had damage classes
    @Column("damage_class_id") public var damageClassId: PokeAPIMoveDamageClass.ID?

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.type(id: id, identifier: identifier)
    }
}
