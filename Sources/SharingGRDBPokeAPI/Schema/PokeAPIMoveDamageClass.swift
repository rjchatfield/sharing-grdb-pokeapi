import SharingGRDB

/// Categorizes moves by how they calculate damage and interact with stats.
/// Physical moves use Attack vs Defense, Special moves use Sp.Attack vs Sp.Defense,
/// and Status moves don't deal direct damage but apply effects instead.
@Table("move_damage_classes")
public struct PokeAPIMoveDamageClass: Decodable, Hashable, Identifiable, Sendable {
    /// Unique damage class identifier (1=Physical, 2=Special, 3=Status)
    @Column("id", primaryKey: true) public var id: Int
    
    /// Machine-readable damage class name ("physical", "special", "status")
    /// Determines which stats are used for damage calculation
    @Column("identifier") public var identifier: String
}
