import StructuredQueries
import Tagged

/// Breeding compatibility groups for Pokemon (Monster, Flying, Dragon, etc.)
@Table("egg_groups")
public struct PokeAPIEggGroup: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this egggroup
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
