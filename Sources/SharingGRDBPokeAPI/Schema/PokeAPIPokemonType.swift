import SharingGRDB

/// Links Pokemon to their types.
@Table("pokemon_types")
public struct PokeAPIPokemonType: Codable, Equatable, Sendable {
    @Column("pokemon_id") public var pokemonId: String
    @Column("type_id") public var typeId: Int
    @Column("slot") public var slot: Int?
}
