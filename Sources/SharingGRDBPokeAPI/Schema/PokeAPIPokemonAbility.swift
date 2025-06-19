import SharingGRDB

/// Links Pokemon to their abilities.
@Table("pokemon_abilities")
public struct PokeAPIPokemonAbility: Decodable, Hashable, Sendable {
    @Column("pokemon_id") public var pokemonId: Int
    @Column("ability_id") public var abilityId: Int
    @Column("is_hidden") public var isHidden: Bool
    @Column("slot") public var slot: Int
}