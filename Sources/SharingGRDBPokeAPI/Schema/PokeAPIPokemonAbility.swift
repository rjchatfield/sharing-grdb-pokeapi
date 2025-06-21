import StructuredQueries

/// Each Pokemon can have 1-3 abilities: up to 2 regular abilities and 1 hidden ability.
/// Only one ability is active at a time, determined by the Pokemon's personality or item.
/// Hidden abilities are typically rarer and obtained through special methods.
@Table("pokemon_abilities")
public struct PokeAPIPokemonAbility: Decodable, Hashable, Sendable {
    /// Foreign key to the pokemon table
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID
    
    /// Foreign key to the abilities table
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID
    
    /// Whether this is a hidden ability (Dream World/Hidden Ability)
    /// Hidden abilities are rarer and often more powerful than regular ones
    @Column("is_hidden") public var isHidden: Bool
    
    /// Ability slot (1-2 for regular abilities, 3 for hidden ability)
    /// Determines which ability the Pokemon has based on its personality
    @Column("slot") public var slot: Int
}
