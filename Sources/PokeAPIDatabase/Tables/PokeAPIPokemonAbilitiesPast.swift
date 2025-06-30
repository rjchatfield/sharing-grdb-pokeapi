import StructuredQueries
import Tagged

/// Historical record of Pokemon abilities from previous generations.
/// Tracks ability changes over time, including removed abilities and slot changes.
/// Used to maintain compatibility with older generation movesets and team compositions.
@Table("pokemon_abilities_past")
public struct PokeAPIPokemonAbilitiesPast: Decodable, Hashable, Sendable {

    /// References the Pokemon that had this historical ability
    @Column("pokemon_id") public var pokemonId: PokeAPIPokemon.ID

    /// Generation in which this ability configuration was active
    @Column("generation_id") public var generationId: PokeAPIGeneration.ID

    /// The ability that was available in this historical configuration
    /// Nil indicates the Pokemon had no ability in this slot during this generation
    @Column("ability_id") public var abilityId: PokeAPIAbility.ID?

    /// Whether this was a hidden ability in the historical configuration
    /// Hidden abilities are typically obtained through special methods
    @Column("is_hidden") public var isHidden: Bool

    /// Ability slot number (1-3) in the historical configuration
    /// Slot 1-2 are regular abilities, slot 3 is typically hidden ability
    @Column("slot") public var slot: Int

}
