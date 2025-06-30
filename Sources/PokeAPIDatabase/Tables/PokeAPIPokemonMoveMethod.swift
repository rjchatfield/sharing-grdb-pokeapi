import StructuredQueries
import Tagged

/// Defines the different methods by which Pokemon can learn moves.
/// Methods include level-up, TM/HM, breeding, tutoring, and other special methods.
/// Each method represents a different way moves can be acquired by Pokemon.
@Table("pokemon_move_methods")
public struct PokeAPIPokemonMoveMethod: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this move learning method
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable method name (e.g., "level-up", "machine", "egg", "tutor")
    /// Identifies how Pokemon can learn moves through this method
    @Column("identifier") public var identifier: Identifier

}