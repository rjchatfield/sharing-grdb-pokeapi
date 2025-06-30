import StructuredQueries
import Tagged

/// Methods by which Pokemon can evolve (level up, trade, use item, etc.)
@Table("evolution_triggers")
public struct PokeAPIEvolutionTrigger: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this evolutiontrigger
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
