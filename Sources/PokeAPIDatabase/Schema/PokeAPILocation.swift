import StructuredQueries

/// Represents major locations within Pokemon regions where Pokemon can be found.
/// Locations contain multiple areas with different Pokemon encounters, items,
/// and events. Examples include cities, routes, caves, and special areas.
@Table("locations")
public struct PokeAPILocation: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int

    /// Unique location identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Region this location belongs to (Kanto, Johto, Hoenn, etc.)
    @Column("region_id") public var regionId: PokeAPIRegion.ID

    /// Machine-readable location name (e.g., "pallet-town", "viridian-forest")
    @Column("identifier") public var identifier: String
}
