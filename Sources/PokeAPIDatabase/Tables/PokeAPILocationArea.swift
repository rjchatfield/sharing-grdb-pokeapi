import StructuredQueries
import Tagged

/// Represents subdivisions of locations where different Pokemon encounters can occur.
/// For example, a cave location might have different areas like "1F", "B1F", or "entrance",
/// each with their own unique encounter tables and Pokemon availability.
@Table("location_areas")
public struct PokeAPILocationArea: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique location area identifier
    @Column("id", primaryKey: true) public var id: ID
    
    /// Machine-readable area name (e.g., "area", "1f", "b1f", "entrance", "summit")
    /// Examples: different floors of buildings, sections of routes, cave depths
    @Column("identifier") public var identifier: Identifier?
    
    /// Parent location this area belongs to
    @Column("location_id") public var locationId: PokeAPILocation.ID

    /// In-game index number for this area
    /// Used internally by the game engine for area identification
    /// Range: 0-183
    @Column("game_index") public var gameIndex: Int

    // MARK: - Helpers

    public var formattedName: String? {
        guard let identifier else { return nil }
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
