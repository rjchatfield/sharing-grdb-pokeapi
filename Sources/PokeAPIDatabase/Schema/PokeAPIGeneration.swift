import StructuredQueries
import Tagged

/// Represents the major Pokemon game generations, each introducing new Pokemon,
/// mechanics, regions, and features. Generations typically span 2-4 years and
/// include multiple game versions (e.g., Red/Blue, Gold/Silver, etc.).
@Table("generations")
public struct PokeAPIGeneration: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Generation number
    ///
    /// - Gen 1 (Red/Blue/Green/Yellow)
    /// - Gen 2 (Gold/Silver/Crystal)
    /// - Gen 3 (Ruby/Sapphire/Emerald/FireRed/LeafGreen)
    /// - Gen 4 (Diamond/Pearl/Platinum/HeartGold/SoulSilver)
    /// - Gen 5 (Black/White/Black2/White2)
    /// - Gen 6 (X/Y/Omega Ruby/Alpha Sapphire)
    /// - Gen 7 (Sun/Moon/Ultra Sun/Ultra Moon)
    /// - Gen 8 (Sword/Shield/Let's Go/Brilliant Diamond/Shining Pearl/Legends Arceus)
    /// - Gen 9 (Scarlet/Violet)
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
