import StructuredQueries
import Tagged

/// Represents the major geographical regions in the Pokemon world.
/// Each region is typically associated with a generation and contains
/// multiple locations, cities, routes, and gym leaders. Examples include
/// Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos, Alola, and Galar.
@Table("regions")
public struct PokeAPIRegion: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique region identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable region name (e.g., "kanto", "johto", "hoenn", "sinnoh")
    /// Each region represents a distinct area with its own Pokemon, culture, and storyline
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.region(id: id, identifier: identifier)
    }
}
