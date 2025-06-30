import StructuredQueries
import Tagged

// TODO: Add description for pokemon_forms table
@Table("pokemon_forms")
public struct PokeAPIPokemonForm: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

    // TODO: Add description for form_identifier
    @Column("form_identifier") public var formIdentifier: String?

    // TODO: Add description for pokemon_id
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    // TODO: Add description for introduced_in_version_group_id
    @Column("introduced_in_version_group_id") public var introducedInVersionGroupId: PokeAPIVersionGroup.ID

    // TODO: Add description for is_default
    @Column("is_default") public var isDefault: Bool

    // TODO: Add description for is_battle_only
    @Column("is_battle_only") public var isBattleOnly: Bool

    // TODO: Add description for is_mega
    @Column("is_mega") public var isMega: Bool

    // TODO: Add description for form_order
    @Column("form_order") public var formOrder: Int

    // TODO: Add description for order
    @Column("order") public var order: Int

}
