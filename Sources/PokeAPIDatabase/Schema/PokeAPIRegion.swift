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

extension PokeAPIRegion.ID {
    public static let kanto  = PokeAPIRegion.ID(1)
    public static let johto  = PokeAPIRegion.ID(2)
    public static let hoenn  = PokeAPIRegion.ID(3)
    public static let sinnoh = PokeAPIRegion.ID(4)
    public static let unova  = PokeAPIRegion.ID(5)
    public static let kalos  = PokeAPIRegion.ID(6)
    public static let alola  = PokeAPIRegion.ID(7)
    public static let galar  = PokeAPIRegion.ID(8)
    public static let paldea = PokeAPIRegion.ID(10)
}
