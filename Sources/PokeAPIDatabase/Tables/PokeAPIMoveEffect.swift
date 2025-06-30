import StructuredQueries
import Tagged

/// Effects that moves can have in battle (damage, status conditions, stat changes, etc.)
@Table("move_effects")
public struct PokeAPIMoveEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    /// Unique identifier for this move effect
    @Column("id", primaryKey: true) public var id: ID
}
