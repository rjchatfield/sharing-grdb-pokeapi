import StructuredQueries
import Tagged

/// Experience point growth rates that determine leveling speed for Pokemon
@Table("growth_rates")
public struct PokeAPIGrowthRate: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this growthrate
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    /// Formula
    @Column("formula") public var formula: String

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
