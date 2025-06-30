import StructuredQueries
import Tagged

/// Natural environments where Pokemon can typically be found
@Table("pokemon_habitats")
public struct PokeAPIPokemonHabitat: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this pokemonhabitat
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable name/identifier
    @Column("identifier") public var identifier: Identifier

    // MARK: - Helpers

    public var formattedName: String {
        return PokeAPIStrings.formatted(identifier: identifier)
    }
}
