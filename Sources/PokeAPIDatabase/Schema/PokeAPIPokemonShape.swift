import StructuredQueries
import Tagged

/// Body shapes and forms used to categorize Pokemon silhouettes
@Table("pokemon_shapes")
public struct PokeAPIPokemonShape: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this pokemonshape
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
