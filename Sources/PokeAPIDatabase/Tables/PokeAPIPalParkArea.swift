import StructuredQueries
import Tagged

/// Represents different areas within Pal Park from Pokemon Diamond/Pearl/Platinum.
/// Pal Park is a location where Pokemon from Game Boy Advance games can be transferred.
/// Each area has different Pokemon species that can appear there.
@Table("pal_park_areas")
public struct PokeAPIPalParkArea: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this Pal Park area
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable area name (e.g., "forest", "field", "mountain", "pond", "sea")
    /// Used to identify which area of Pal Park this represents
    @Column("identifier") public var identifier: Identifier

}