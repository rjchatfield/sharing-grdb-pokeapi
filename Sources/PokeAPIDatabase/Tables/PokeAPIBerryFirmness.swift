import StructuredQueries
import Tagged

/// Defines the physical firmness categories of berries in the Pokemon world.
/// Firmness affects how berries behave when used in Pokemon contests or cooking recipes,
/// ranging from very soft to super hard textures.
@Table("berry_firmness")
public struct PokeAPIBerryFirmness: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// The primary key identifier for this berry firmness level
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable firmness level name (e.g., "very-soft", "soft", "hard", "very-hard", "super-hard")
    /// Used to categorize berries by their physical texture properties
    @Column("identifier") public var identifier: Identifier

}