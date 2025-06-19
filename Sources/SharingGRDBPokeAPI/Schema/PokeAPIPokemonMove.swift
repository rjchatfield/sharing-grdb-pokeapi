import SharingGRDB

/// Links Pokemon to their moves with learning method and level.
@Table("pokemon_moves")
public struct PokeAPIPokemonMove: Decodable, Hashable, Sendable {
    @Column("pokemon_id") public var pokemonId: Int
    @Column("version_group_id") public var versionGroupId: Int
    @Column("move_id") public var moveId: Int
    @Column("pokemon_move_method_id") public var pokemonMoveMethodId: Int
    @Column("level") public var level: Int
    @Column("order") public var order: Int?
    @Column("mastery") public var mastery: String?
}