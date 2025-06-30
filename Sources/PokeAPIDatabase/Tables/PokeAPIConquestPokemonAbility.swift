import StructuredQueries
import Tagged

/// Abilities that Pokemon species possess in Pokemon Conquest.
/// These abilities provide passive effects during tactical battles.
/// Abilities work similarly to main series games but are adapted for the tactical combat system.
@Table("conquest_pokemon_abilities")
public struct PokeAPIConquestPokemonAbility: Decodable, Hashable, Sendable {

    /// The Pokemon species that has this ability
    /// Each species can have one or more possible abilities
    @Column("pokemon_species_id") public var pokemonSpeciesId: PokeAPIPokemonSpecy.ID

    /// The ability slot (1, 2, or 3 for hidden ability)
    /// Determines which ability slot this ability occupies
    @Column("slot") public var slot: Int

    /// The specific ability this Pokemon species can have
    /// References the main ability database
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID

}