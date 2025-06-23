import StructuredQueries
import Tagged

/// Represents major locations within Pokemon regions where Pokemon can be found.
/// Locations contain multiple areas with different Pokemon encounters, items,
/// and events. Examples include cities, routes, caves, and special areas.
@Table("locations")
public struct PokeAPILocation: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique location identifier
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable location name (e.g., "pallet-town", "viridian-forest")
    @Column("identifier") public var identifier: Identifier

    /// Region this location belongs to (Kanto, Johto, Hoenn, etc.)
    @Column("region_id") public var regionId: PokeAPIRegion.ID

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.location(id: id, identifier: identifier)
    }
}
