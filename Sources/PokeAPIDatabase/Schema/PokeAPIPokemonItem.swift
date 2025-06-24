import StructuredQueries
import Tagged

/// Items that wild Pokemon can be found holding when encountered
@Table("pokemon_items")
public struct PokeAPIPokemonItem: Decodable, Hashable, Sendable {
    /// Foreign key to pokemon
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// Foreign key to version
    @Column("version_id") public var versionId: PokeAPIVersion.ID

    /// Foreign key to item
    @Column("item_id") public var itemId: PokeAPIItem.ID

    /// Rarity
    @Column("rarity") public var rarity: Int
}
