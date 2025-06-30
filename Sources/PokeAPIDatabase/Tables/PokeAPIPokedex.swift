import StructuredQueries
import Tagged

/// Regional and national Pokedexes that catalog Pokemon
@Table("pokedexes")
public struct PokeAPIPokedex: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this pokedex
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    /// Foreign key to region
    @Column("region_id") public var regionId: PokeAPIRegion.ID?

    /// Is main series
    @Column("is_main_series") public var isMainSeries: Int

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
