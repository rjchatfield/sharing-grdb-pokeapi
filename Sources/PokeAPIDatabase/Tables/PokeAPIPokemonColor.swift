import StructuredQueries
import Tagged

/// Primary colors used to categorize Pokemon appearance
@Table("pokemon_colors")
public struct PokeAPIPokemonColor: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this pokemoncolor
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
