import StructuredQueries
import Tagged

/// Categorizes moves by their primary battle effect and purpose.
/// Groups moves into categories like damage-dealing, status-inflicting, healing,
/// stat-modifying, and field effects for easier organization and analysis.
@Table("move_meta_categories")
public struct PokeAPIMoveMetaCategory: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this move meta category
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable category name (e.g., "damage", "ailment", "heal")
    /// Used to classify moves by their primary battle effect
    @Column("identifier") public var identifier: Identifier

}