import StructuredQueries

/// Represents the major Pokemon game generations, each introducing new Pokemon,
/// mechanics, regions, and features. Generations typically span 2-4 years and
/// include multiple game versions (e.g., Red/Blue, Gold/Silver, etc.).
@Table("generations")
public struct PokeAPIGeneration: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Int
    public typealias Identifier = String

    /// Generation number (1=Red/Blue, 2=Gold/Silver, 3=Ruby/Sapphire, etc.)
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable generation name (e.g., "generation-i", "generation-iv")
    @Column("identifier") public var identifier: Identifier

    /// Primary region associated with this generation
    /// Example: Gen 1 = Kanto, Gen 2 = Johto, Gen 3 = Hoenn
    @Column("main_region_id") public var mainRegionId: PokeAPIRegion.ID

    // MARK: - Helpers

    public var localizedName: String {
        return PokeAPIStrings.generation(id: id, identifier: identifier)
    }
}
